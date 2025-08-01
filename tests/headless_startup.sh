#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR/..

# Set XDG variables to ensure proper runtime paths
export XDG_CONFIG_HOME="$(pwd)"
export XDG_DATA_HOME="$(pwd)"
export XDG_CACHE_HOME="$(pwd)/cache"

output=$(nvim --headless -c 'qa' 2>&1 || true)

if echo "$output" | grep -iE 'error|warning'; then
  echo "$output"
  echo "Headless startup produced errors or warnings" >&2
  exit 1
else
  echo "$output"
  echo "Headless startup succeeded without errors or warnings"
fi

cd -
