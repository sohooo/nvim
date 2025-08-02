#!/bin/bash
set -e

DIR="$(dirname "$0")"

if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim not found; installing latest release..."
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT
  os="$(uname -s)"
  arch="$(uname -m)"
  if [ "$os" = "Linux" ]; then
    if [ "$arch" = "x86_64" ] || [ "$arch" = "amd64" ]; then
      asset="nvim-linux-x86_64.tar.gz"
      dir="nvim-linux-x86_64"
    elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
      asset="nvim-linux-arm64.tar.gz"
      dir="nvim-linux-arm64"
    else
      echo "Unsupported architecture for automatic Neovim installation: $arch" >&2
      exit 1
    fi
    curl -L "https://github.com/neovim/neovim/releases/latest/download/$asset" -o "$tmp_dir/nvim.tar.gz"
    tar -C "$tmp_dir" -xzf "$tmp_dir/nvim.tar.gz"
    export PATH="$tmp_dir/$dir/bin:$PATH"
  elif [ "$os" = "Darwin" ]; then
    if [ "$arch" = "x86_64" ]; then
      asset="nvim-macos-x86_64.tar.gz"
      dir="nvim-macos-x86_64"
    elif [ "$arch" = "arm64" ]; then
      asset="nvim-macos-arm64.tar.gz"
      dir="nvim-macos-arm64"
    else
      echo "Unsupported architecture for automatic Neovim installation: $arch" >&2
      exit 1
    fi
    curl -L "https://github.com/neovim/neovim/releases/latest/download/$asset" -o "$tmp_dir/nvim.tar.gz"
    tar -C "$tmp_dir" -xzf "$tmp_dir/nvim.tar.gz"
    export PATH="$tmp_dir/$dir/bin:$PATH"
  else
    echo "Unsupported OS for automatic Neovim installation: $os" >&2
    exit 1
  fi
fi

bash "$DIR/headless_startup.sh"
