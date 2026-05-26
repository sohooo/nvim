#!/usr/bin/env bash
set -euo pipefail

required=(
  git
  nvim
)

optional=(
  make
  rg
  fd
  fzf
  trash
  lazygit
  tree-sitter
  gopls
  ruff
  rust-analyzer
  ruby-lsp
  lua-language-server
  puppet-languageserver
  codex
  claude
  gemini
  copilot-language-server
)

missing_required=0

printf 'Required tools:\n'
for tool in "${required[@]}"; do
  if path="$(command -v "$tool" 2>/dev/null)"; then
    printf '  ok       %-24s %s\n' "$tool" "$path"
  else
    printf '  missing  %-24s required\n' "$tool"
    missing_required=1
  fi
done

printf '\nOptional tools:\n'
for tool in "${optional[@]}"; do
  if path="$(command -v "$tool" 2>/dev/null)"; then
    printf '  ok       %-24s %s\n' "$tool" "$path"
  else
    printf '  missing  %-24s optional\n' "$tool"
  fi
done

if [[ "$missing_required" -ne 0 ]]; then
  exit 1
fi
