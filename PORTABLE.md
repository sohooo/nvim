# Portable Setup

Neovim and Packer (plugin manager) follow common `XDG` env vars, so if we put the config in `~/.config`, everything will work out of the box:

```bash
cd
mkdir .config; cd $_
git clone https://github.com/sohooo/nvim.git
nvim
# plugin installation; see README.md
```

## self-contained/portable usage

Cloning this repo to `~/.config/nvim` is the recommended location and will mostly work. Per Default, plugins will be put in `XDG_DATA_HOME`. These are the relevant paths and env variables:

```lua
-- $XDG_CONFIG_HOME
:echo stdpath('config')
/Users/sohooo/.config/nvim

-- $XDG_DATA_HOME
:echo stdpath('data')
/Users/sohooo/.local/share/nvim
```

We can modify the `XDG_` env vars to put everything in one directory. The following alias ensures that everything lands in `./config/nvim`:

```bash
export MY_NVIM_PATH=/tmp/config
alias v='XDG_CONFIG_HOME=$MY_NVIM_PATH XDG_DATA_HOME=$MY_NVIM_PATH nvim'
```

## custom location

In order to install everything self-contained in another path, you would simply do the following (using the alias defined above):

```bash
export MY_NVIM_PATH=/tmp/config
mkdir $MY_NVIM_PATH && cd $_

# in /tmp/config
git clone https://github.com/sohooo/nvim.git

# start nvim using this config
v
```

## plugins

This config uses Packer to manage Neovim plugins. To install them, you do one of the following:

```bash
# start neovim, then run packer install
v
:PackerInstall

# or: try everything with one command
v --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# start again to install missing LSP servers, Treesitter grammars, ...
v

# restart nvim, then check if everything's there ;)
:PackerStatus    # show plugin status
:TSInstallInfo   # check if all Treesitter grammars present
:Mason           # install additional LSP server
```
