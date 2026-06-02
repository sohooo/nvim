# Airgap Bundle

This repo supports two Linux x86_64 airgap artifacts:

- a GitHub release AppImage built from Fedora userspace;
- a local tarball that contains an already extracted runtime.

Both include Neovim, this config, pinned lazy.nvim plugins, and compiled
Treesitter parsers.

## Contents

Both artifact types include:

- the latest stable official `nvim-linux-x86_64.appimage`, extracted at build
  time;
- this config under `config/nvim`;
- lazy.nvim plugins restored from `lazy-lock.json`;
- compiled Treesitter parsers configured in `lua/plugins/treesitter.lua`;
- bundled `data/nvim` for lazy.nvim plugins and parser artifacts.

The bundle does not include LSP servers, AI CLIs, or optional editor CLI tools.
Those remain host-provided and are documented in
[External tools](external-tools.md).

## GitHub Release AppImage

The release workflow builds `nvim-airgap-linux-x86_64.AppImage` from a Fedora
container on GitHub Actions. The Ubuntu runner only hosts the container; build
dependencies and parser compilation run in Fedora userspace to better match
Red Hat based targets.

The workflow publishes the verified asset to the `latest` release.

Run normally:

```bash
chmod +x nvim-airgap-linux-x86_64.AppImage
./nvim-airgap-linux-x86_64.AppImage
```

Run without FUSE:

```bash
chmod +x nvim-airgap-linux-x86_64.AppImage
./nvim-airgap-linux-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
```

Optional install-style extraction:

```bash
sudo mv squashfs-root /opt/nvim-airgap
ln -s /opt/nvim-airgap/AppRun ~/.local/bin/nvim-airgap
```

The AppImage is read-only at runtime. Its launcher uses bundled config/data and
host-writable state, cache, and runtime directories.

## Build AppImage Locally

Local AppImage builds require a Linux x86_64 machine with internet access:

```bash
make airgap-appimage
```

The build host must provide `git`, `curl`, `tar`, `awk`, `sed`, `sha256sum` or
`shasum`, a C compiler usable by nvim-treesitter, and the `tree-sitter` CLI.
The script downloads `appimagetool` and falls back to its extracted `AppRun` if
FUSE is unavailable during packaging.

Verify the local AppImage:

```bash
make verify-airgap-appimage APPIMAGE=dist/nvim-airgap-linux-x86_64.AppImage
```

The verifier tries normal AppImage execution when available and always verifies
FUSE-free extracted mode.

## Build Tarball Locally

Tarball builds require a Linux x86_64 machine with internet access:

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

## Verify Tarball

Verify a built tarball before moving it into an airgapped environment:

```bash
make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz
```

The verifier extracts the tarball into a temporary directory, starts the
bundled Neovim through `bin/nvim`, runs the existing plugin smoke checks, and
checks that active plugin commits and Treesitter parser artifacts are present.

## Run Tarball Offline

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
3. For release AppImages, push to `master` or run the workflow manually.
4. For local tarballs, build with `make airgap-bundle` on a Linux x86_64 host.
5. Verify the artifact before moving it into the airgapped environment.
