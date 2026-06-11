#!/usr/bin/env bash
set -euo pipefail

ARCH="linux-x86_64"
APPIMAGE_NAME="nvim-${ARCH}.appimage"
RELEASE_API="https://api.github.com/repos/neovim/neovim/releases/latest"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT/dist"
BUILD_DIR="$DIST_DIR/build/airgap-${ARCH}"
DOWNLOAD_DIR="$BUILD_DIR/downloads"
STAGE_DIR="$BUILD_DIR/stage"
BUNDLE_NAME=""
BUNDLE_ROOT=""

usage() {
  cat <<'USAGE'
Usage: scripts/build-airgap-bundle.sh

Build a Linux x86_64, airgap-ready Neovim tarball with:
  - the latest official Neovim AppImage extracted for FUSE-free runtime
  - this config
  - lazy.nvim plugins restored from lazy-lock.json
  - configured nvim-treesitter parsers

Environment:
  KEEP_BUILD=1  Keep dist/build/airgap-linux-x86_64 after the build.
USAGE
}

die() {
  echo "error: $*" >&2
  exit 1
}

need() {
  command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"
}

sha256_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{ print $1 }'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{ print $1 }'
  else
    die "missing sha256sum or shasum"
  fi
}

json_escape() {
  sed 's/\\/\\\\/g; s/"/\\"/g'
}

json_array() {
  local first=1
  printf '['
  while IFS= read -r item; do
    [[ -n "$item" ]] || continue
    if [[ "$first" -eq 0 ]]; then
      printf ','
    fi
    first=0
    printf '"%s"' "$(printf '%s' "$item" | json_escape)"
  done
  printf ']'
}

extract_asset_field() {
  local field="$1"
  awk -v asset="$APPIMAGE_NAME" -v field="$field" '
    $0 ~ "\"name\": \"" asset "\"" { in_asset = 1 }
    in_asset && $0 ~ "\"" field "\":" {
      line = $0
      sub("^.*\"" field "\": *\"", "", line)
      sub("\".*$", "", line)
      print line
      exit
    }
    in_asset && $0 ~ /^    \}/ { in_asset = 0 }
  '
}

treesitter_languages() {
  awk '
    /local parser_languages = \{/ { in_list = 1; next }
    in_list && /\}/ { exit }
    in_list {
      while (match($0, /"[^"]+"/)) {
        value = substr($0, RSTART + 1, RLENGTH - 2)
        print value
        $0 = substr($0, RSTART + RLENGTH)
      }
    }
  ' "$ROOT/lua/plugins/treesitter.lua"
}

plugin_names() {
  sed -n 's/^  "\([^"]*\)":.*/\1/p' "$ROOT/lazy-lock.json"
}

lock_field() {
  local plugin="$1"
  local field="$2"

  awk -v plugin="$plugin" -v field="$field" '
    index($0, "\"" plugin "\":") {
      line = $0
      sub("^.*\"" field "\": *\"", "", line)
      sub("\".*$", "", line)
      print line
      exit
    }
  ' "$ROOT/lazy-lock.json"
}

bootstrap_lazy_nvim() {
  local lazy_dir="$BUNDLE_ROOT/data/nvim/lazy/lazy.nvim"
  local lazy_branch
  local lazy_commit

  lazy_branch="$(lock_field lazy.nvim branch)"
  lazy_commit="$(lock_field lazy.nvim commit)"

  [[ -n "$lazy_branch" ]] || die "lazy.nvim branch missing from lazy-lock.json"
  [[ -n "$lazy_commit" ]] || die "lazy.nvim commit missing from lazy-lock.json"

  mkdir -p "$(dirname "$lazy_dir")"
  git clone --filter=blob:none --branch "$lazy_branch" https://github.com/folke/lazy.nvim.git "$lazy_dir"
  git -C "$lazy_dir" checkout --detach "$lazy_commit"
  [[ "$(git -C "$lazy_dir" rev-parse HEAD)" == "$lazy_commit" ]] || die "failed to pin lazy.nvim to $lazy_commit"
}

pin_plugins_to_lock() {
  local plugin
  local plugin_dir
  local commit

  while IFS= read -r plugin; do
    [[ -n "$plugin" ]] || continue
    plugin_dir="$BUNDLE_ROOT/data/nvim/lazy/$plugin"
    commit="$(lock_field "$plugin" commit)"

    [[ -n "$commit" ]] || die "$plugin commit missing from lazy-lock.json"
    [[ -d "$plugin_dir/.git" ]] || continue

    if ! git -C "$plugin_dir" cat-file -e "$commit^{commit}" >/dev/null 2>&1; then
      git -C "$plugin_dir" fetch --filter=blob:none origin "$commit"
    fi

    git -C "$plugin_dir" checkout --detach "$commit"
    [[ "$(git -C "$plugin_dir" rev-parse HEAD)" == "$commit" ]] || die "failed to pin $plugin to $commit"
  done < <(plugin_names)
}

write_build_lua_scripts() {
  cat >"$BUILD_DIR/restore-lazy.lua" <<'LUA'
local function fail(message)
  vim.api.nvim_err_writeln(message)
  vim.cmd("cquit 1")
end

local ok, err = xpcall(function()
  require("lazy.manage").restore({ wait = true, show = false })
end, debug.traceback)

if not ok then
  fail(err)
end

vim.cmd("quitall!")
LUA

  cat >"$BUILD_DIR/check-lazy-restore.lua" <<'LUA'
local function fail(message)
  vim.api.nvim_err_writeln(message)
  vim.cmd("cquit 1")
end

local Config = require("lazy.core.config")
local Git = require("lazy.manage.git")
local Lock = require("lazy.manage.lock")

Lock._loaded = false
Lock.load()

local failures = {}

for _, plugin in pairs(Config.plugins) do
  if plugin.url and not plugin._.is_local then
    local lock = Lock.get(plugin)
    if not lock then
      table.insert(failures, plugin.name .. " is active but missing from lazy-lock.json")
    elseif not plugin._.installed then
      table.insert(failures, plugin.name .. " is active but was not installed")
    else
      local info = Git.info(plugin.dir)
      if info.commit ~= lock.commit then
        table.insert(failures, plugin.name .. " is at " .. tostring(info.commit) .. " instead of " .. lock.commit)
      end
    end
  end
end

if #failures > 0 then
  fail("lazy restore verification failed:\n" .. table.concat(failures, "\n"))
end

vim.cmd("quitall!")
LUA

  cat >"$BUILD_DIR/install-treesitter.lua" <<'LUA'
local function fail(message)
  vim.api.nvim_err_writeln(message)
  vim.cmd("cquit 1")
end

local ok, err = xpcall(function()
  require("lazy.core.loader").load({ "nvim-treesitter" }, { cmd = "airgap bundle" })

  local languages = vim.split(vim.env.AIRGAP_TS_LANGUAGES or "", "%s+", { trimempty = true })
  if #languages == 0 then
    error("AIRGAP_TS_LANGUAGES is empty")
  end

  local install = require("nvim-treesitter.install").install
  for _, language in ipairs(languages) do
    local task = install({ language }, { summary = true })
    local success = task:wait()
    if not success then
      error("failed to install Treesitter parser: " .. language)
    end
  end
end, debug.traceback)

if not ok then
  fail(err)
end

vim.cmd("quitall!")
LUA
}

copy_config() {
  mkdir -p "$BUNDLE_ROOT/config/nvim"
  (
    cd "$ROOT"
    git ls-files -z | tar --null -T - -cf - | tar -C "$BUNDLE_ROOT/config/nvim" -xf -
  )
}

write_launcher() {
  mkdir -p "$BUNDLE_ROOT/bin"
  cat >"$BUNDLE_ROOT/bin/nvim" <<'LAUNCHER'
#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_ROOT="$(cd "$BIN_DIR/.." && pwd)"
APPDIR="$BUNDLE_ROOT/opt/nvim-appimage/squashfs-root"

if [[ ! -x "$APPDIR/AppRun" ]]; then
  echo "error: bundled Neovim AppRun is missing or not executable: $APPDIR/AppRun" >&2
  exit 1
fi

if [[ ! -r "$BUNDLE_ROOT/config/nvim/scripts/airgap-paths.sh" ]]; then
  echo "error: bundled airgap path helper is missing: $BUNDLE_ROOT/config/nvim/scripts/airgap-paths.sh" >&2
  exit 1
fi

export APPDIR
export NVIM_AIRGAP="${NVIM_AIRGAP:-1}"
export XDG_CONFIG_HOME="$BUNDLE_ROOT/config"
export XDG_DATA_HOME="$BUNDLE_ROOT/data"

# shellcheck source=scripts/airgap-paths.sh
source "$BUNDLE_ROOT/config/nvim/scripts/airgap-paths.sh"
airgap_prepare_xdg_paths

if [[ -d "$BUNDLE_ROOT/tools/bin" ]]; then
  export PATH="$BUNDLE_ROOT/tools/bin:$PATH"
fi

exec "$APPDIR/AppRun" "$@"
LAUNCHER
  chmod 755 "$BUNDLE_ROOT/bin/nvim"
}

write_readme() {
  cat >"$BUNDLE_ROOT/README.airgap.md" <<'README'
# Airgap Neovim Bundle

This directory contains a FUSE-free Neovim runtime built from the official
Linux x86_64 AppImage, plus the pinned config plugins and Treesitter parsers.

## Run

```bash
./bin/nvim
```

The launcher keeps config, data, state, cache, and runtime files inside this
directory. It executes the extracted AppImage at
`opt/nvim-appimage/squashfs-root/AppRun`, so FUSE is not required.

## Verify

```bash
./bin/nvim --version
./bin/nvim --headless "+qa"
```

The bundle intentionally does not include external LSP servers or editor CLIs.
Install those on the host when needed.
README
}

write_manifest() {
  local appimage_sha="$1"
  local appimage_url="$2"
  local nvim_version="$3"
  local bundle_git_commit="$4"
  local lock_sha="$5"
  local plugins_json
  local parsers_json

  plugins_json="$(plugin_names | json_array)"
  parsers_json="$(treesitter_languages | json_array)"

  cat >"$BUNDLE_ROOT/manifest.json" <<MANIFEST
{
  "name": "nvim-airgap",
  "platform": "$ARCH",
  "built_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "git_commit": "$bundle_git_commit",
  "nvim_version": "$(printf '%s' "$nvim_version" | json_escape)",
  "appimage": {
    "url": "$appimage_url",
    "sha256": "$appimage_sha",
    "runtime": "opt/nvim-appimage/squashfs-root/AppRun"
  },
  "config": {
    "lockfile": "config/nvim/lazy-lock.json",
    "lockfile_sha256": "$lock_sha"
  },
  "plugins": $plugins_json,
  "treesitter_languages": $parsers_json
}
MANIFEST
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
  "")
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac

[[ "$(uname -s)" == "Linux" ]] || die "AppImage extraction must run on Linux"
[[ "$(uname -m)" == "x86_64" ]] || die "this bundle target requires x86_64"

need curl
need git
need tar
need awk
need sed
need chmod
need paste
need tree-sitter

if ! command -v cc >/dev/null 2>&1 && ! command -v gcc >/dev/null 2>&1 && ! command -v clang >/dev/null 2>&1; then
  die "missing C compiler: expected cc, gcc, or clang"
fi

mkdir -p "$DOWNLOAD_DIR"
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR"

release_json="$DOWNLOAD_DIR/neovim-latest-release.json"
curl -fsSL "$RELEASE_API" -o "$release_json"

tag="$(sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' "$release_json" | head -n 1)"
[[ -n "$tag" ]] || die "could not determine latest Neovim tag"

appimage_url="$(extract_asset_field browser_download_url <"$release_json")"
digest="$(extract_asset_field digest <"$release_json")"
expected_sha="${digest#sha256:}"

[[ -n "$appimage_url" ]] || die "could not find $APPIMAGE_NAME in latest release $tag"
[[ -n "$expected_sha" && "$expected_sha" != "$digest" ]] || die "could not find sha256 digest for $APPIMAGE_NAME"

appimage="$DOWNLOAD_DIR/$APPIMAGE_NAME"
curl -fL "$appimage_url" -o "$appimage"
chmod 755 "$appimage"

actual_sha="$(sha256_file "$appimage")"
[[ "$actual_sha" == "$expected_sha" ]] || die "sha256 mismatch for $APPIMAGE_NAME"

BUNDLE_NAME="nvim-airgap-${ARCH}-${tag}-$(date -u +%Y%m%d)"
BUNDLE_ROOT="$STAGE_DIR/$BUNDLE_NAME"
mkdir -p "$BUNDLE_ROOT/opt/nvim-appimage" "$BUNDLE_ROOT/data" "$BUNDLE_ROOT/state" "$BUNDLE_ROOT/cache" "$BUNDLE_ROOT/run"
chmod 700 "$BUNDLE_ROOT/run"

(
  cd "$BUNDLE_ROOT/opt/nvim-appimage"
  "$appimage" --appimage-extract >/dev/null
)
ln -sfn "squashfs-root/AppRun" "$BUNDLE_ROOT/opt/nvim-appimage/AppRun"

copy_config
write_launcher
write_readme
write_build_lua_scripts
bootstrap_lazy_nvim
staged_lock_sha_before="$(sha256_file "$BUNDLE_ROOT/config/nvim/lazy-lock.json")"

export NVIM_AIRGAP=0
export NVIM_AIRGAP_BUILD=1
export NVIM_AIRGAP_STATE_HOME="$BUNDLE_ROOT/state"
export NVIM_AIRGAP_CACHE_HOME="$BUNDLE_ROOT/cache"
export NVIM_AIRGAP_RUNTIME_DIR="$BUNDLE_ROOT/run"
export XDG_CONFIG_HOME="$BUNDLE_ROOT/config"
export XDG_DATA_HOME="$BUNDLE_ROOT/data"
export XDG_STATE_HOME="$NVIM_AIRGAP_STATE_HOME"
export XDG_CACHE_HOME="$NVIM_AIRGAP_CACHE_HOME"
export XDG_RUNTIME_DIR="$NVIM_AIRGAP_RUNTIME_DIR"

nvim_bin="$BUNDLE_ROOT/bin/nvim"
nvim_version="$("$nvim_bin" --version | head -n 1)"

"$nvim_bin" --headless "+luafile $BUILD_DIR/restore-lazy.lua"
staged_lock_sha_after="$(sha256_file "$BUNDLE_ROOT/config/nvim/lazy-lock.json")"
if [[ "$staged_lock_sha_after" != "$staged_lock_sha_before" ]]; then
  echo "lazy.nvim rewrote the staged lazy-lock.json during restore; restoring the source lockfile"
  cp "$ROOT/lazy-lock.json" "$BUNDLE_ROOT/config/nvim/lazy-lock.json"
fi
pin_plugins_to_lock
"$nvim_bin" --headless "+luafile $BUILD_DIR/check-lazy-restore.lua"
AIRGAP_TS_LANGUAGES="$(treesitter_languages | paste -sd' ' -)" "$nvim_bin" --headless "+luafile $BUILD_DIR/install-treesitter.lua"
"$nvim_bin" --headless "+qa"

bundle_git_commit="$(git -C "$ROOT" rev-parse HEAD)"
lock_sha="$(sha256_file "$ROOT/lazy-lock.json")"
write_manifest "$actual_sha" "$appimage_url" "$nvim_version" "$bundle_git_commit" "$lock_sha"

mkdir -p "$DIST_DIR"
tarball="$DIST_DIR/$BUNDLE_NAME.tar.gz"
(
  cd "$STAGE_DIR"
  tar -czf "$tarball" "$BUNDLE_NAME"
)

echo "Airgap bundle written to $tarball"

if [[ "${KEEP_BUILD:-0}" != "1" ]]; then
  rm -rf "$BUILD_DIR"
fi
