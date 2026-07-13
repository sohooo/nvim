#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEMO="$ROOT/tests/fixtures/ruby-lsp-demo"

if ! command -v ruby-lsp >/dev/null 2>&1; then
  echo "ruby-lsp not found on PATH; skipping Ruby LSP integration check"
  exit 0
fi

(
  cd "$DEMO"
  "$ROOT/scripts/nvim.sh" --headless \
    "+edit lib/demo/use_calculator.rb" \
    "+luafile $ROOT/tests/fixtures/ruby-lsp-demo/verify-ruby-lsp.lua" \
    "+qa"
)
