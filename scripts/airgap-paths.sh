#!/usr/bin/env bash

airgap_path_owner() {
  local path="${1:-}"

  [[ -n "$path" && -e "$path" ]] || return 1

  if stat -c %u "$path" >/dev/null 2>&1; then
    stat -c %u "$path"
  elif stat -f %u "$path" >/dev/null 2>&1; then
    stat -f %u "$path"
  else
    return 1
  fi
}

airgap_passwd_home() {
  local uid="$1"

  if command -v getent >/dev/null 2>&1; then
    getent passwd "$uid" | awk -F: 'NR == 1 { print $6 }'
  elif [[ -r /etc/passwd ]]; then
    awk -F: -v uid="$uid" '$3 == uid { print $6; exit }' /etc/passwd
  fi
}

airgap_resolve_base_home() {
  local uid="$1"
  local passwd_home="${2:-}"
  local env_home="${3:-}"
  local env_home_owner="${4:-}"
  local tmpdir="${5:-/tmp}"

  if [[ -n "$passwd_home" && -d "$passwd_home" ]]; then
    printf '%s\n' "$passwd_home"
  elif [[ -n "$env_home" && -d "$env_home" && "$env_home_owner" == "$uid" ]]; then
    printf '%s\n' "$env_home"
  else
    printf '%s/nvim-airgap-home-%s\n' "${tmpdir:-/tmp}" "$uid"
  fi
}

airgap_prepare_xdg_paths() {
  local uid
  local passwd_home
  local home_owner
  local base_home
  local state_home
  local cache_home
  local runtime_home

  uid="$(id -u)"
  passwd_home="$(airgap_passwd_home "$uid" || true)"
  home_owner="$(airgap_path_owner "${HOME:-}" || true)"
  base_home="$(airgap_resolve_base_home "$uid" "$passwd_home" "${HOME:-}" "$home_owner" "${TMPDIR:-/tmp}")"

  state_home="${NVIM_AIRGAP_STATE_HOME:-$base_home/.local/state/nvim-airgap}"
  cache_home="${NVIM_AIRGAP_CACHE_HOME:-$base_home/.cache/nvim-airgap}"
  runtime_home="${NVIM_AIRGAP_RUNTIME_DIR:-${TMPDIR:-/tmp}/nvim-airgap-$uid}"

  mkdir -p "$state_home/nvim" "$cache_home/nvim" "$runtime_home/tmp"
  chmod 700 "$state_home" "$state_home/nvim" "$cache_home" "$cache_home/nvim" "$runtime_home" "$runtime_home/tmp" 2>/dev/null || true

  export XDG_STATE_HOME="$state_home"
  export XDG_CACHE_HOME="$cache_home"
  export XDG_RUNTIME_DIR="$runtime_home"
  export TMPDIR="$runtime_home/tmp"

  if [[ "${NVIM_AIRGAP_DEBUG_PATHS:-0}" == "1" ]]; then
    {
      printf 'nvim-airgap uid: %s\n' "$uid"
      printf 'nvim-airgap base home: %s\n' "$base_home"
      printf 'nvim-airgap state: %s\n' "$XDG_STATE_HOME"
      printf 'nvim-airgap cache: %s\n' "$XDG_CACHE_HOME"
      printf 'nvim-airgap runtime: %s\n' "$XDG_RUNTIME_DIR"
      printf 'nvim-airgap tmp: %s\n' "$TMPDIR"
    } >&2
  fi
}
