#!/usr/bin/env bash
set -euo pipefail

ARCH="linux-x86_64"
APPIMAGE_NAME="nvim-${ARCH}.appimage"
OUTPUT_NAME="nvim-airgap-linux-x86_64.AppImage"
RELEASE_API="https://api.github.com/repos/neovim/neovim/releases/latest"
APPIMAGETOOL_URL="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT/dist"
BUILD_DIR="$DIST_DIR/build/appimage-${ARCH}"
DOWNLOAD_DIR="$BUILD_DIR/downloads"
APPDIR="$BUILD_DIR/AppDir"

# shellcheck source=scripts/airgap-build-lib.sh
source "$ROOT/scripts/airgap-build-lib.sh"

usage() {
  cat <<'USAGE'
Usage: scripts/build-airgap-appimage.sh

Build a Linux x86_64, single-file AppImage with:
  - the latest official Neovim AppImage extracted inside the AppDir
  - this config
  - lazy.nvim plugins restored from lazy-lock.json
  - configured nvim-treesitter parsers

Environment:
  KEEP_BUILD=1  Keep dist/build/appimage-linux-x86_64 after the build.
USAGE
}

die() { airgap_die "$@"; }
need() { airgap_need "$@"; }
sha256_file() { airgap_sha256_file "$@"; }
json_escape() { airgap_json_escape "$@"; }
json_array() { airgap_json_array "$@"; }
extract_asset_field() { airgap_extract_asset_field "$APPIMAGE_NAME" "$@"; }
treesitter_languages() { airgap_treesitter_languages "$@"; }
plugin_names() { airgap_plugin_names "$@"; }
lock_field() { airgap_lock_field "$@"; }

copy_config() {
  mkdir -p "$APPDIR/config/nvim"
  (
    cd "$ROOT"
    git ls-files -z | tar --null -T - -cf - | tar -C "$APPDIR/config/nvim" -xf -
  )
}

bootstrap_lazy_nvim() {
  airgap_bootstrap_lazy_nvim "$APPDIR/data/nvim"
}

pin_plugins_to_lock() {
  airgap_pin_plugins_to_lock "$APPDIR/data/nvim"
}

write_build_lua_scripts() {
  airgap_write_build_lua_scripts "$BUILD_DIR" appimage
}

write_apprun() {
  cat >"$APPDIR/AppRun" <<'APPRUN'
#!/usr/bin/env bash
set -euo pipefail

OUTER_APPDIR="${APPDIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
NVIM_APPDIR="$OUTER_APPDIR/opt/nvim-appimage/squashfs-root"

if [[ ! -x "$NVIM_APPDIR/AppRun" ]]; then
  echo "error: bundled Neovim AppRun is missing or not executable: $NVIM_APPDIR/AppRun" >&2
  exit 1
fi

if [[ ! -r "$OUTER_APPDIR/config/nvim/scripts/airgap-paths.sh" ]]; then
  echo "error: bundled airgap path helper is missing: $OUTER_APPDIR/config/nvim/scripts/airgap-paths.sh" >&2
  exit 1
fi

export NVIM_AIRGAP=1
export XDG_CONFIG_HOME="$OUTER_APPDIR/config"
export XDG_DATA_HOME="$OUTER_APPDIR/data"

# shellcheck source=scripts/airgap-paths.sh
source "$OUTER_APPDIR/config/nvim/scripts/airgap-paths.sh"
airgap_prepare_xdg_paths

if [[ -d "$OUTER_APPDIR/tools/bin" ]]; then
  export PATH="$OUTER_APPDIR/tools/bin:$PATH"
fi

export APPDIR="$NVIM_APPDIR"
exec "$NVIM_APPDIR/AppRun" "$@"
APPRUN
  chmod 755 "$APPDIR/AppRun"
}

write_desktop_files() {
  cat >"$APPDIR/nvim-airgap.desktop" <<'DESKTOP'
[Desktop Entry]
Type=Application
Name=Neovim Airgap
Comment=Airgap-ready Neovim configuration
Exec=nvim-airgap
Icon=nvim-airgap
Categories=Utility;TextEditor;Development;
Terminal=true
DESKTOP

  local icon_source
  icon_source="$(find "$APPDIR/opt/nvim-appimage/squashfs-root" -iname 'nvim*.png' -o -name '.DirIcon' | head -n 1 || true)"
  if [[ -n "$icon_source" ]]; then
    cp "$icon_source" "$APPDIR/nvim-airgap.png"
  else
    cat >"$APPDIR/nvim-airgap.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
  <rect width="128" height="128" fill="#111827"/>
  <path d="M24 20h20l40 64V20h20v88H84L44 44v64H24z" fill="#57A143"/>
</svg>
SVG
  fi

  if command -v desktop-file-validate >/dev/null 2>&1; then
    desktop-file-validate "$APPDIR/nvim-airgap.desktop"
  fi
}

write_readme() {
  cat >"$APPDIR/README.airgap.md" <<'README'
# Airgap Neovim AppImage

Run normally:

```bash
./nvim-airgap-linux-x86_64.AppImage
```

Run without FUSE:

```bash
./nvim-airgap-linux-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
```

The image contains Neovim, this config, pinned lazy.nvim plugins, and compiled
Treesitter parsers. External LSP servers and editor CLIs remain host-provided.
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

  cat >"$APPDIR/manifest.json" <<MANIFEST
{
  "name": "nvim-airgap-appimage",
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

run_appimagetool() {
  local tool="$DOWNLOAD_DIR/appimagetool-x86_64.AppImage"
  local output="$DIST_DIR/$OUTPUT_NAME"

  curl -fL "$APPIMAGETOOL_URL" -o "$tool"
  chmod 755 "$tool"

  mkdir -p "$DIST_DIR"
  rm -f "$output"
  ARCH=x86_64 APPIMAGE_EXTRACT_AND_RUN=1 "$tool" "$APPDIR" "$output"
  chmod 755 "$output"
  echo "Airgap AppImage written to $output"
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

[[ "$(uname -s)" == "Linux" ]] || die "AppImage build must run on Linux"
[[ "$(uname -m)" == "x86_64" ]] || die "this AppImage target requires x86_64"

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
rm -rf "$APPDIR"
mkdir -p "$APPDIR/opt/nvim-appimage" "$APPDIR/data" "$APPDIR/config" "$APPDIR/tools"

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

(
  cd "$APPDIR/opt/nvim-appimage"
  "$appimage" --appimage-extract >/dev/null
)
ln -sfn "squashfs-root/AppRun" "$APPDIR/opt/nvim-appimage/AppRun"

copy_config
write_build_lua_scripts
bootstrap_lazy_nvim
write_apprun
write_desktop_files
write_readme
staged_lock_sha_before="$(sha256_file "$APPDIR/config/nvim/lazy-lock.json")"

export NVIM_AIRGAP=0
export NVIM_AIRGAP_BUILD=1
export NVIM_AIRGAP_STATE_HOME="$BUILD_DIR/state"
export NVIM_AIRGAP_CACHE_HOME="$BUILD_DIR/cache"
export NVIM_AIRGAP_RUNTIME_DIR="$BUILD_DIR/run"
export XDG_CONFIG_HOME="$APPDIR/config"
export XDG_DATA_HOME="$APPDIR/data"
export XDG_STATE_HOME="$NVIM_AIRGAP_STATE_HOME"
export XDG_CACHE_HOME="$NVIM_AIRGAP_CACHE_HOME"
export XDG_RUNTIME_DIR="$NVIM_AIRGAP_RUNTIME_DIR"
mkdir -p "$XDG_STATE_HOME" "$XDG_CACHE_HOME" "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

nvim_bin="$APPDIR/AppRun"
nvim_version="$("$nvim_bin" --version | head -n 1)"

"$nvim_bin" --headless "+luafile $BUILD_DIR/restore-lazy.lua"
staged_lock_sha_after="$(sha256_file "$APPDIR/config/nvim/lazy-lock.json")"
if [[ "$staged_lock_sha_after" != "$staged_lock_sha_before" ]]; then
  echo "lazy.nvim rewrote the staged lazy-lock.json during restore; restoring the source lockfile"
  cp "$ROOT/lazy-lock.json" "$APPDIR/config/nvim/lazy-lock.json"
fi
pin_plugins_to_lock
"$nvim_bin" --headless "+luafile $BUILD_DIR/check-lazy-restore.lua"
AIRGAP_TS_LANGUAGES="$(treesitter_languages | paste -sd' ' -)" "$nvim_bin" --headless "+luafile $BUILD_DIR/install-treesitter.lua"
"$nvim_bin" --headless "+qa"

bundle_git_commit="$(git -C "$ROOT" rev-parse HEAD)"
lock_sha="$(sha256_file "$ROOT/lazy-lock.json")"
write_manifest "$actual_sha" "$appimage_url" "$nvim_version" "$bundle_git_commit" "$lock_sha"

run_appimagetool

if [[ "${KEEP_BUILD:-0}" != "1" ]]; then
  rm -rf "$BUILD_DIR"
fi
