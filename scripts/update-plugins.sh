#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export XDG_CONFIG_HOME="$ROOT"
export XDG_DATA_HOME="$ROOT"
export XDG_CACHE_HOME="$ROOT/cache"

nvim --headless "+Lazy! update" +qa

