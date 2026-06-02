#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'USAGE'
Usage: scripts/verify-airgap-appimage.sh <AppImage>

Verify an airgap Neovim AppImage, including extracted FUSE-free mode.
USAGE
}

die() {
  echo "error: $*" >&2
  exit 1
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

write_lazy_restore_check() {
  cat >"$tmp/check-lazy-restore.lua" <<'LUA'
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
}

[[ "${1:-}" != "" ]] || {
  usage >&2
  exit 2
}
[[ "${1:-}" != "-h" && "${1:-}" != "--help" ]] || {
  usage
  exit 0
}

appimage="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
[[ -f "$appimage" ]] || die "AppImage not found: $appimage"
[[ -x "$appimage" ]] || chmod 755 "$appimage"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
write_lazy_restore_check

if "$appimage" --version >/dev/null 2>&1; then
  echo "Normal AppImage execution verified"
else
  echo "Normal AppImage execution unavailable; continuing with extracted FUSE-free verification"
fi

extract_dir="$tmp/extract"
mkdir -p "$extract_dir"
(
  cd "$extract_dir"
  "$appimage" --appimage-extract >/dev/null
)

appdir="$extract_dir/squashfs-root"
[[ -x "$appdir/AppRun" ]] || die "missing executable extracted AppRun"
[[ -x "$appdir/opt/nvim-appimage/squashfs-root/AppRun" ]] || die "missing bundled Neovim AppRun"
[[ -f "$appdir/manifest.json" ]] || die "missing manifest.json"

export HOME="$tmp/home"
mkdir -p "$HOME"

"$appdir/AppRun" --version >/dev/null
"$appdir/AppRun" --headless "+qa"

NVIM_BIN="$appdir/AppRun" \
XDG_CONFIG_HOME="$appdir/config" \
XDG_DATA_HOME="$appdir/data" \
XDG_STATE_HOME="$tmp/state" \
XDG_CACHE_HOME="$tmp/cache" \
XDG_RUNTIME_DIR="$tmp/run" \
  "$appdir/config/nvim/scripts/verify-plugins.sh"

"$appdir/AppRun" --headless "+luafile $tmp/check-lazy-restore.lua"

missing_parser=0
while IFS= read -r language; do
  if ! find "$appdir/data/nvim" -path "*/parser/${language}.so" -type f | grep -q .; then
    echo "missing Treesitter parser: $language" >&2
    missing_parser=1
  fi
done < <(treesitter_languages)
[[ "$missing_parser" -eq 0 ]] || exit 1

if [[ -e "$HOME/.local/share/nvim" || -e "$HOME/.config/nvim" || -e "$HOME/.cache/nvim" ]]; then
  die "verification wrote Neovim files outside the configured XDG paths"
fi

echo "Airgap AppImage verified: $appimage"
