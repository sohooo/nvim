#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT="$ROOT/docs/healthcheck.md"

if [[ ! -f "$REPORT" ]]; then
  echo "error: missing healthcheck report: $REPORT" >&2
  exit 1
fi

accepted_patterns=(
  'WARNING Some providers may show up as "disabled" but are enabled dynamically'
  'WARNING `lua` version `5\.1` needed'
  'WARNING \{lua5\.1\} or \{lua\} or \{lua-5\.1\} version `5\.1` not installed'
  'WARNING `fzf` is not installed'
  'ERROR `tree-sitter \(CLI\)` is not installed'
  'ERROR setup did not run'
  "ERROR None of the tools found: 'kitty', 'wezterm', 'ghostty'"
  "ERROR None of the tools found: 'magick', 'convert'"
  'ERROR `magick` is required to convert images'
  'WARNING Missing Treesitter languages:'
  'WARNING Image rendering in docs with missing treesitter parsers'
  "ERROR Tool not found: 'gs'"
  'WARNING `gs` is required to render PDF files'
  "ERROR None of the tools found: 'tectonic', 'pdflatex'"
  'WARNING `tectonic` or `pdflatex` is required to render LaTeX math expressions'
  "ERROR Tool not found: 'mmdc'"
  'WARNING `mmdc` is required to render Mermaid diagrams'
  'ERROR your terminal does not support the kitty graphics protocol'
  'ERROR is not ready'
  'WARNING `regex`'
  'WARNING setup \{disabled\}'
  "WARNING 'puppet-languageserver' is not executable"
)

unaccepted=0
while IFS= read -r line; do
  matched=0
  for pattern in "${accepted_patterns[@]}"; do
    if [[ "$line" =~ $pattern ]]; then
      matched=1
      break
    fi
  done

  if [[ "$matched" -eq 0 ]]; then
    printf 'unaccepted healthcheck finding: %s\n' "$line" >&2
    unaccepted=1
  fi
done < <(grep -E 'ERROR|WARNING' "$REPORT" || true)

if [[ "$unaccepted" -ne 0 ]]; then
  printf 'Update docs/healthcheck-findings.md and scripts/verify-healthcheck.sh after reviewing new findings.\n' >&2
  exit 1
fi

echo "Healthcheck findings match the accepted baseline"
