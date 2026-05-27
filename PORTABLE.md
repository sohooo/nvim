# Portable Setup

This repository can be used as a self-contained Neovim config without copying
files into `~/.config/nvim`.

## Launcher

Use the launcher in this repository to run the installed `nvim` binary with
this project's config and local runtime directories:

```bash
./scripts/nvim.sh
```

The launcher sets `XDG_CONFIG_HOME` to the parent directory of this checkout so
Neovim discovers this repository as `$XDG_CONFIG_HOME/nvim`.

It keeps runtime state self-contained under `.xdg/` in the repository:

- `.xdg/data/nvim`: lazy.nvim, plugins, parser data, and other data files
- `.xdg/state/nvim`: ShaDa and state files
- `.xdg/cache/nvim`: cache files
- `.xdg/run`: runtime socket directory

To use a specific Neovim binary, set `NVIM_BIN`:

```bash
NVIM_BIN=/path/to/nvim ./scripts/nvim.sh
```

## Plugins

This config uses LazyVim and lazy.nvim. On first startup, lazy.nvim bootstraps
the configured plugins into the project-local `.xdg/data/nvim` directory:

```bash
./scripts/nvim.sh
```

Useful checks inside Neovim:

```vim
:Lazy
:checkhealth
```

For a non-interactive startup check, run:

```bash
tests/run.sh
```

## External Tools

Mason is disabled. Language servers, formatters, linters, debuggers, and AI CLI
tools should be installed outside this config and available on `PATH`.

See [docs/external-tools.md](docs/external-tools.md) for the current policy.

## Airgap Bundle

For Linux x86_64 systems, this repo can build a tarball that includes an
extracted official Neovim AppImage, this config, pinned lazy.nvim plugins, and
compiled Treesitter parsers:

```bash
make airgap-bundle
make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz
```

The AppImage is extracted during the build, so the resulting bundle runs on
target systems without FUSE. See
[docs/airgap-bundle.md](docs/airgap-bundle.md) for the full workflow.
