# Airgap Bundle

The airgap bundle is a Linux x86_64 tarball that can be extracted and run
without installing Neovim, copying files into `~/.config/nvim`, or mounting an
AppImage through FUSE.

## Contents

The bundle includes:

- the latest stable official `nvim-linux-x86_64.appimage`, extracted at build
  time;
- this config under `config/nvim`;
- lazy.nvim plugins restored from `lazy-lock.json`;
- compiled Treesitter parsers configured in `lua/plugins/treesitter.lua`;
- self-contained `data`, `state`, `cache`, and `run` directories.

The bundle does not include LSP servers, AI CLIs, or optional editor CLI tools.
Those remain host-provided and are documented in
[External tools](external-tools.md).

## Build

Builds require a Linux x86_64 machine with internet access:

```bash
make airgap-bundle
```

The build host must provide `git`, `curl`, `tar`, `awk`, `sed`, `sha256sum` or
`shasum`, a C compiler usable by nvim-treesitter, and the `tree-sitter` CLI.

The build script downloads the latest Neovim AppImage from GitHub, verifies its
published SHA256 digest, extracts it with `--appimage-extract`, restores plugins
from the lockfile, installs Treesitter parsers, and writes a tarball under
`dist/`.

Keep the temporary build directory for debugging with:

```bash
KEEP_BUILD=1 make airgap-bundle
```

## Verify

Verify a built tarball before moving it into an airgapped environment:

```bash
make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz
```

The verifier extracts the tarball into a temporary directory, starts the
bundled Neovim through `bin/nvim`, runs the existing plugin smoke checks, and
checks that plugin directories and Treesitter parser artifacts are present.

## Run Offline

Copy the tarball to the target machine, extract it, and run:

```bash
./bin/nvim
```

The launcher executes `opt/nvim-appimage/squashfs-root/AppRun` directly. This
is the extracted AppImage runtime, so FUSE is not required on the target host.
The launcher sets all XDG paths inside the extracted bundle directory.

## Update Workflow

1. Update the config, plugins, or Treesitter language list in the normal repo.
2. Run `make verify`.
3. Build with `make airgap-bundle` on a Linux x86_64 build host.
4. Verify with `make verify-airgap-bundle TARBALL=<tarball>`.
5. Move the verified tarball into the airgapped environment.
