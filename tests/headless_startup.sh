#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."

# Set XDG variables to ensure proper runtime paths
export XDG_CONFIG_HOME="$(pwd)"
export XDG_DATA_HOME="$(pwd)"
export XDG_CACHE_HOME="$(pwd)/cache"

# Run Neovim with the repository's init.lua and capture output
set +e
output=$(nvim --headless -u init.lua -c 'qa' 2>&1)
status=$?
set -e

if [ $status -ne 0 ] || echo "$output" | grep -iE 'error|warning' >/dev/null; then
  echo "$output"
  echo "Headless startup failed with errors or warnings" >&2
  exit 1
else
  echo "$output"
  echo "Headless startup succeeded without errors or warnings"
fi

cd - >/dev/null
