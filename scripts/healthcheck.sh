#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT="$ROOT/docs/healthcheck.md"
HEALTH_OUTPUT="$(mktemp)"
COMMAND_OUTPUT="$(mktemp)"

cleanup() {
  rm -f "$HEALTH_OUTPUT" "$COMMAND_OUTPUT"
}
trap cleanup EXIT

set +e
"$ROOT/scripts/nvim.sh" --headless "+checkhealth" "+noautocmd silent write! $HEALTH_OUTPUT" "+qa!" >"$COMMAND_OUTPUT" 2>&1
status=$?
output="$(cat "$COMMAND_OUTPUT")"
health="$(cat "$HEALTH_OUTPUT")"
set -e

errors="$(printf '%s\n%s\n' "$output" "$health" | grep -c "ERROR" || true)"
warnings="$(printf '%s\n%s\n' "$output" "$health" | grep -c "WARNING" || true)"

{
  printf '# Neovim Healthcheck\n\n'
  printf 'Generated with `scripts/healthcheck.sh`.\n\n'
  printf '%s\n\n' "- Exit status: \`$status\`"
  printf '%s\n' "- Errors: \`$errors\`"
  printf '%s\n\n' "- Warnings: \`$warnings\`"
  printf '## Report\n\n'
  printf '```text\n'
  printf '%s\n' "$health"
  printf '```\n\n'
  printf '## Command Output\n\n'
  printf '```text\n'
  printf '%s\n' "$output"
  printf '```\n'
} >"$REPORT"

if [[ "$status" -ne 0 ]]; then
  printf 'Healthcheck exited with status %s; report written to %s\n' "$status" "$REPORT" >&2
  exit "$status"
fi

printf 'Healthcheck report written to %s\n' "$REPORT"
