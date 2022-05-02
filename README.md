> a modern and highly opinionated lua config for neovim 0.7+

## self-contained/portable usage

Neovim and Packer (plugin manager) follow common `XDG` env vars:

```lua
-- $XDG_CONFIG_HOME
:echo stdpath('config')
/Users/sohooo/.config/nvim

-- $XDG_DATA_HOME
:echo stdpath('data')
/Users/sohooo/.local/share/nvim
```

Cloning this repo to `~/.config/nvim` will mostly work, but the plugins will be put in `XDG_DATA_HOME`. However, the following alias ensures that everything lands in `./config/nvim`:

```bash
alias v='XDG_CONFIG_HOME=~/.config XDG_DATA_HOME=~/.config nvim'

# or some custom parent path to this repo
# this repo would be placed in ~/.dotfiles/nvim
alias v='XDG_CONFIG_HOME=~/.dotfiles XDG_DATA_HOME=~/.dotfiles nvim'
```

