# Portable Setup

Neovim follows common `XDG` env vars, so if we put the config in `~/.config`, everything will work out of the box:

```bash
cd
mkdir .config; cd $_
git clone https://github.com/sohooo/nvim.git
nvim
# plugin installation starts
```

## self-contained/custom location

Use the launcher in this repository to run the installed `nvim` binary with this
project's config and local runtime directories:

```bash
./scripts/nvim.sh
```

The launcher sets `XDG_CONFIG_HOME` to the parent directory of this checkout so
Neovim discovers this repository as `$XDG_CONFIG_HOME/nvim`. It keeps runtime
state self-contained under `.xdg/` in the repository:

- `.xdg/data/nvim`: plugins, lazy.nvim, parser data, and other data files
- `.xdg/state/nvim`: ShaDa and state files
- `.xdg/cache/nvim`: cache files
- `.xdg/run`: runtime socket directory

To use a specific Neovim binary, set `NVIM_BIN`:

```bash
NVIM_BIN=/path/to/nvim ./scripts/nvim.sh
```

## plugins

This config uses [lazy.nvim](https://github.com/folke/lazy.nvim#-performance) to manage Neovim plugins. To install them, you do one of the following:

```bash
# start neovim with the repo-local launcher
# this will install all plugins
./scripts/nvim.sh

# restart nvim, then check if everything's there ;)
:Lazy            # plugins
:TSInstallInfo   # Treesitter grammars
```

For LSP servers, I previously used [Mason](https://github.com/williamboman/mason.nvim). Now, I just use a package manager and put them in the `$PATH`.
