#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/airgap-paths.sh
source "$ROOT/scripts/airgap-paths.sh"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

assert_eq() {
  local expected="$1"
  local actual="$2"
  local label="$3"

  if [[ "$actual" != "$expected" ]]; then
    echo "error: $label: expected $expected, got $actual" >&2
    exit 1
  fi
}

mkdir -p "$tmp/root" "$tmp/funky" "$tmp/owned"

assert_eq "$tmp/root" \
  "$(airgap_resolve_base_home 0 "$tmp/root" "$tmp/funky" 1000 "$tmp")" \
  "root prefers passwd home over inherited user HOME"

assert_eq "$tmp/funky" \
  "$(airgap_resolve_base_home 1000 "$tmp/funky" "$tmp/funky" 1000 "$tmp")" \
  "normal user uses passwd home"

assert_eq "$tmp/owned" \
  "$(airgap_resolve_base_home 12345 "" "$tmp/owned" 12345 "$tmp")" \
  "missing passwd home falls back to owned HOME"

assert_eq "$tmp/nvim-airgap-home-12345" \
  "$(airgap_resolve_base_home 12345 "" "$tmp/funky" 1000 "$tmp")" \
  "mismatched HOME owner falls back to tmp home"

override_root="$tmp/overrides"
NVIM_AIRGAP_STATE_HOME="$override_root/state" \
NVIM_AIRGAP_CACHE_HOME="$override_root/cache" \
NVIM_AIRGAP_RUNTIME_DIR="$override_root/run" \
HOME="$tmp/funky" \
TMPDIR="$tmp/tmp" \
  bash -c '
    set -euo pipefail
    source "$1"
    airgap_prepare_xdg_paths
    [[ "$XDG_STATE_HOME" == "$2/state" ]]
    [[ "$XDG_CACHE_HOME" == "$2/cache" ]]
    [[ "$XDG_RUNTIME_DIR" == "$2/run" ]]
    [[ "$TMPDIR" == "$2/run/tmp" ]]
  ' _ "$ROOT/scripts/airgap-paths.sh" "$override_root"

echo "Airgap path resolver verified"
