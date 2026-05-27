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

plugin_names() {
  sed -n 's/^  "\([^"]*\)":.*/\1/p' "$ROOT/lazy-lock.json"
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

tar -xzf "$tarball" -C "$tmp"

bundle_root="$(find "$tmp" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
[[ -n "$bundle_root" ]] || die "tarball did not contain a top-level bundle directory"
[[ -x "$bundle_root/bin/nvim" ]] || die "missing executable bundle launcher"
[[ -x "$bundle_root/opt/nvim-appimage/squashfs-root/AppRun" ]] || die "missing extracted AppRun"
[[ -f "$bundle_root/manifest.json" ]] || die "missing manifest.json"

export HOME="$tmp/home"
mkdir -p "$HOME"

"$bundle_root/bin/nvim" --version >/dev/null
"$bundle_root/bin/nvim" --headless "+qa"

NVIM_BIN="$bundle_root/bin/nvim" \
XDG_CONFIG_HOME="$bundle_root/config" \
XDG_DATA_HOME="$bundle_root/data" \
XDG_STATE_HOME="$bundle_root/state" \
XDG_CACHE_HOME="$bundle_root/cache" \
XDG_RUNTIME_DIR="$bundle_root/run" \
  "$bundle_root/config/nvim/scripts/verify-plugins.sh"

missing_plugin=0
while IFS= read -r plugin; do
  [[ -d "$bundle_root/data/nvim/lazy/$plugin" ]] || {
    echo "missing plugin directory: $plugin" >&2
    missing_plugin=1
  }
done < <(plugin_names)
[[ "$missing_plugin" -eq 0 ]] || exit 1

missing_parser=0
while IFS= read -r language; do
  if ! find "$bundle_root/data/nvim" -path "*/parser/${language}.so" -type f | grep -q .; then
    echo "missing Treesitter parser: $language" >&2
    missing_parser=1
  fi
done < <(treesitter_languages)
[[ "$missing_parser" -eq 0 ]] || exit 1

if [[ -e "$HOME/.local/share/nvim" || -e "$HOME/.config/nvim" || -e "$HOME/.cache/nvim" ]]; then
  die "verification wrote Neovim files outside the bundle XDG paths"
fi

echo "Airgap bundle verified: $tarball"
