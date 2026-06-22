#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failed=0

while IFS= read -r -d '' file; do
  dir="$(dirname "$file")"

  while IFS= read -r target; do
    target="${target%%#*}"
    target="${target#<}"
    target="${target%>}"

    [[ -n "$target" ]] || continue
    [[ "$target" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*: ]] && continue
    [[ "$target" == /* ]] && check_path="$target" || check_path="$dir/$target"

    if [[ ! -e "$check_path" ]]; then
      printf 'broken docs link in %s: %s\n' "${file#"$ROOT"/}" "$target" >&2
      failed=1
    fi
  done < <(
    grep -Eo '\[[^]]+\]\([^)]+\)' "$file" \
      | sed -E 's/^.*\]\(([^)]+)\)$/\1/' \
      || true
  )
done < <(find "$ROOT" \( -path "$ROOT/.git" -o -path "$ROOT/.xdg" -o -path "$ROOT/dist" -o -path "$ROOT/prev_cfg" -o -path "$ROOT/tmp" \) -prune -o -name '*.md' -type f -print0)

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

echo "Documentation links verified"
