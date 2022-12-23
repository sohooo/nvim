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

We can modify the `XDG_` env vars to put everything in one directory. The following alias ensures that everything lands in `/tmp/config/nvim`:

```bash
export CUSTOM_NVIM_PATH=/tmp/config
mkdir $CUSTOM_NVIM_PATH && cd $_
alias v="XDG_CONFIG_HOME=$CUSTOM_NVIM_PATH XDG_DATA_HOME=$CUSTOM_NVIM_PATH nvim"

# in /tmp/config
git clone https://github.com/sohooo/nvim.git

# start nvim using this config
# this will install all plugins; wait until Treesitter grammars, LSP servers etc are installed
v
```

## plugins

This config uses [lazy.nvim](https://github.com/folke/lazy.nvim#-performance) to manage Neovim plugins. To install them, you do one of the following:

```bash
# start neovim
# this will install all plugins
v

# install some LSP servers
# more can be installed via :Mason
:MasonInstallAll

# restart nvim, then check if everything's there ;)
:Lazy            # plugins
:Mason           # LSP server, linter, formatter, ...
:TSInstallInfo   # Treesitter grammars
```
