#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_PATH="$SCRIPT_DIR/../init.lua"

output=$(nvim --headless -u "$CONFIG_PATH" -c 'qa' 2>&1 || true)

if echo "$output" | grep -iE 'error|warning'; then
  echo "$output"
  echo "Headless startup produced errors or warnings" >&2
  exit 1
else
  echo "$output"
  echo "Headless startup succeeded without errors or warnings"
fi
