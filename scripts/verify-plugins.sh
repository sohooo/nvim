#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERIFY_LUA="$ROOT/scripts/verify-plugins.lua"
export VERIFY_LUA

bash "$ROOT/scripts/check-migration-status.sh"
bash "$ROOT/tests/run.sh"

"$ROOT/scripts/nvim.sh" --headless \
  -c 'doautocmd User VeryLazy' \
  -c 'lua dofile(vim.env.VERIFY_LUA)' \
  -c 'qa'

echo "Plugin smoke checks succeeded"
