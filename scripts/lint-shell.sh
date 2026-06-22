#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$ROOT"/scripts/*.sh

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck -e SC2016,SC2119,SC2120 "$ROOT"/scripts/*.sh
else
  echo "shellcheck not found; skipped optional shell lint"
fi
