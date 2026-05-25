#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TODO="$ROOT/TODO.md"

if [[ ! -f "$TODO" ]]; then
  printf 'Missing TODO.md\n' >&2
  exit 1
fi

section_lines() {
  local section="$1"

  awk -v section="$section" '
    $0 == "## " section {
      in_section = 1
      next
    }
    /^## / && in_section {
      exit
    }
    in_section {
      print
    }
  ' "$TODO"
}

todo_section="$(section_lines todo)"
deferred_section="$(section_lines deferred)"
todo_items="$(printf '%s\n' "$todo_section" | awk '/^- / { print }')"
has_empty_marker=0

if printf '%s\n' "$todo_section" | grep -qx 'No active migration items\.'; then
  has_empty_marker=1
fi

if [[ -n "$todo_items" && "$has_empty_marker" -eq 1 ]]; then
  printf 'TODO.md has both active todo items and the empty todo marker.\n' >&2
  exit 1
fi

if [[ -z "$todo_items" && "$has_empty_marker" -eq 0 ]]; then
  printf 'TODO.md has no active todo items but is missing the empty todo marker.\n' >&2
  exit 1
fi

printf 'Active migration items:\n'
if [[ -n "$todo_items" ]]; then
  printf '%s\n' "$todo_items"
else
  printf '  none\n'
  printf '  promote the next item with docs/migration-workflow.md\n'
fi

printf '\nDeferred migration items:\n'
deferred_items="$(printf '%s\n' "$deferred_section" | awk '/^- / { print }')"
if [[ -n "$deferred_items" ]]; then
  printf '%s\n' "$deferred_items"
else
  printf '  none\n'
fi
