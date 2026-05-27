#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PARENT="$(dirname "$ROOT")"
XDG_ROOT="$ROOT/.xdg"

mkdir -p "$XDG_ROOT/data" "$XDG_ROOT/state" "$XDG_ROOT/cache" "$XDG_ROOT/run"
chmod 700 "$XDG_ROOT/run"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$PARENT}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$XDG_ROOT/data}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$XDG_ROOT/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$XDG_ROOT/cache}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$XDG_ROOT/run}"

exec "${NVIM_BIN:-nvim}" "$@"
