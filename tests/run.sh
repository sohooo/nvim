#!/bin/bash
set -e

DIR="$(dirname "$0")"

if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim not found; installing latest release..."
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT
  os="$(uname -s)"
  if [ "$os" = "Linux" ]; then
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -o "$tmp_dir/nvim.tar.gz"
    tar -C "$tmp_dir" -xzf "$tmp_dir/nvim.tar.gz"
    export PATH="$tmp_dir/nvim-linux64/bin:$PATH"
  elif [ "$os" = "Darwin" ]; then
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-macos-universal.tar.gz -o "$tmp_dir/nvim.tar.gz"
    tar -C "$tmp_dir" -xzf "$tmp_dir/nvim.tar.gz"
    export PATH="$tmp_dir/nvim-macos-universal/bin:$PATH"
  else
    echo "Unsupported OS for automatic Neovim installation: $os" >&2
    exit 1
  fi
fi

bash "$DIR/headless_startup.sh"
