#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'USAGE'
Usage: scripts/verify-airgap-bundle.sh <tarball>

Extract and verify an airgap Neovim bundle without requiring FUSE.
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

parser_artifacts() {
  local language="$1"

  case "$language" in
    bash)
      printf '%s\n' bash sh
      ;;
    *)
      printf '%s\n' "$language"
      ;;
  esac
}

[[ "${1:-}" != "" ]] || {
  usage >&2
  exit 2
}
[[ "${1:-}" != "-h" && "${1:-}" != "--help" ]] || {
  usage
  exit 0
}

tarball="$1"
[[ -f "$tarball" ]] || die "tarball not found: $tarball"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
write_lazy_restore_check

tar -xzf "$tarball" -C "$tmp"

bundle_root="$(find "$tmp" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
[[ -n "$bundle_root" ]] || die "tarball did not contain a top-level bundle directory"
[[ -x "$bundle_root/bin/nvim" ]] || die "missing executable bundle launcher"
[[ -x "$bundle_root/opt/nvim-appimage/squashfs-root/AppRun" ]] || die "missing extracted AppRun"
[[ -f "$bundle_root/manifest.json" ]] || die "missing manifest.json"
[[ -f "$bundle_root/config/nvim/scripts/airgap-paths.sh" ]] || die "missing bundled airgap path helper"
grep -q "airgap_prepare_xdg_paths" "$bundle_root/bin/nvim" || die "bundle launcher does not use shared airgap path helper"

export HOME="$tmp/home"
mkdir -p "$HOME"

NVIM_AIRGAP_STATE_HOME="$tmp/state" \
NVIM_AIRGAP_CACHE_HOME="$tmp/cache" \
NVIM_AIRGAP_RUNTIME_DIR="$tmp/run" \
  "$bundle_root/bin/nvim" --version >/dev/null
NVIM_AIRGAP_STATE_HOME="$tmp/state" \
NVIM_AIRGAP_CACHE_HOME="$tmp/cache" \
NVIM_AIRGAP_RUNTIME_DIR="$tmp/run" \
  "$bundle_root/bin/nvim" --headless "+qa"

NVIM_BIN="$bundle_root/bin/nvim" \
NVIM_AIRGAP_STATE_HOME="$tmp/state" \
NVIM_AIRGAP_CACHE_HOME="$tmp/cache" \
NVIM_AIRGAP_RUNTIME_DIR="$tmp/run" \
XDG_CONFIG_HOME="$bundle_root/config" \
XDG_DATA_HOME="$bundle_root/data" \
XDG_STATE_HOME="$tmp/state" \
XDG_CACHE_HOME="$tmp/cache" \
XDG_RUNTIME_DIR="$tmp/run" \
  "$bundle_root/config/nvim/scripts/verify-plugins.sh"

NVIM_AIRGAP_STATE_HOME="$tmp/state" \
NVIM_AIRGAP_CACHE_HOME="$tmp/cache" \
NVIM_AIRGAP_RUNTIME_DIR="$tmp/run" \
  "$bundle_root/bin/nvim" --headless "+luafile $tmp/check-lazy-restore.lua"

missing_parser=0
while IFS= read -r language; do
  found_parser=0
  while IFS= read -r artifact; do
    if find "$bundle_root/data/nvim" -path "*/parser/${artifact}.so" -type f | grep -q .; then
      found_parser=1
      break
    fi
  done < <(parser_artifacts "$language")

  if [[ "$found_parser" -eq 0 ]]; then
    echo "missing Treesitter parser: $language" >&2
    missing_parser=1
  fi
done < <(treesitter_languages)
[[ "$missing_parser" -eq 0 ]] || exit 1

if [[ -e "$HOME/.local/share/nvim" || -e "$HOME/.local/state/nvim-airgap" || -e "$HOME/.config/nvim" || -e "$HOME/.cache/nvim" || -e "$HOME/.cache/nvim-airgap" ]]; then
  die "verification wrote Neovim files outside the bundle XDG paths"
fi

echo "Airgap bundle verified: $tarball"
