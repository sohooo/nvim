> my __highly opinionated__ neovim 0.8+ lua config

## Features

- modern nvim 0.8+ lua-based config with telescope and lsp
- complete package with useful plugins, autocommands, bindings and colorschemes
- fully portable; place this repo anywhere you want (see below)
- nicely structured and fine-tuned `init.loa` config
- enhanced markdown editing with folding, fenced code hightighting and TOC
- regex commands (like search/replace) with live preview; change directly in quickfix list
- smart text objects: select text, then use `.` to enlage selection
- manage git repo with [neogit](https://github.com/TimUntersberger/neogit)
- [which-key](https://github.com/folke/which-key.nvim): displays a popup with possible keybindings of the command you started typing

__Note:__ if you need something established and well maintained, backed by a large community to answer your questions, I highly recommend checking out:
- [AstroVim](https://astronvim.github.io)
- [LunarVim](https://github.com/ChristianChiarulli/LunarVim)
- [Nvchad](https://nvchad.github.io)


## Installation

First, you need to [install Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim). Then, follow one of the following methods:
- __default location__: follow `XDG` env conventions and put this config in `~/.config` to have `./config/nvim`
- __portable/custom location__: custom location for this config by setting `XDG` env vars

### default location

Neovim and Packer (plugin manager) follow common `XDG` env vars, so if we put the config in `~/.config`, everything will work out of the box:

```bash
cd
mkdir .config; cd $_
git clone https://github.com/sohooo/nvim.git
nvim
# plugin installation; see below
```

### self-contained/portable usage

```lua
-- $XDG_CONFIG_HOME
:echo stdpath('config')
/Users/sohooo/.config/nvim

-- $XDG_DATA_HOME
:echo stdpath('data')
/Users/sohooo/.local/share/nvim
```

Cloning this repo to `~/.config/nvim` is the recommended location and will mostly work, but the plugins will be put in `XDG_DATA_HOME`. However, the following alias ensures that everything lands in `./config/nvim`:

```bash
alias v='XDG_CONFIG_HOME=~/.config XDG_DATA_HOME=~/.config nvim'

# set NVIM_STYLE=plain to use lo-fi version, without nerdfonts
NVIM_STYLE=plain v test.rb
```

To install in another path, you would simply do the following:

```bash
cd /tmp
mkdir config && cd $_

# in /tmp/config
git clone https://github.com/sohooo/nvim.git

# start nvim using this config
XDG_CONFIG_HOME=/tmp/config XDG_DATA_HOME=/tmp/config nvim
```

## Plugins

This config uses Packer to manage Neovim plugins. To install them, you do one of the following:

```bash
# start neovim, then run packer install
XDG_CONFIG_HOME=/tmp/config XDG_DATA_HOME=/tmp/config nvim
:PackerInstall

# or try everything with one command
XDG_CONFIG_HOME=/tmp/config XDG_DATA_HOME=/tmp/config nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# start again to install missing LSP servers, Treesitter grammars, ...
XDG_CONFIG_HOME=/tmp/config XDG_DATA_HOME=/tmp/config nvim

# check if everything's there ;)
:PackerStatus
:TSInstallInfo
:Mason
```

## Bindings

Here's a list of some useful keymaps. Just start typing and wait for the context-sensitive `which-key` popup. Try it with `,` (the Leader key) and wait to see further options. Alternatively, call `:WhichKey` to see all of them. You can also search trough them with the `:Telescope keymaps`.

### Finding stuff with Telescope

* `,f` git_files || find_files
* `,s` live_grep ("search")
* `,b` buffers

[Telescope bindings](https://github.com/nvim-telescope/telescope.nvim#mappings) to select/open files (same for nvim-tree):

* `<C-n|p>` (insert mode) movement, completion; scroll lsp help docs with `<c-j|k>`
* `<C-t>`   open in tab
* `<C-v>`   open in vertical split
* `<C-x>`   open in horizontal split
* toggle seletion with `(s)-tab`
* close selected buffers with `<c-d>`


### other lsp/telescope keymaps

* `gd | gD` preview/goto definition
* `gi | gI` preview/goto implemention
* `gr | gR` preview/goto references
* `K`    show docs
* `gs`   show signatur help
* `gp`   go to preview actions
* `,c` code actions:
  * `a`  action
  * `r`  rename
  * `s`  reformat file
* `,t` telescope stuff:
  * `e`  toggleterm
  * `o`  todos
  * `r`  Trouble
  * `s`  go to symbol
* `,g` git actions
  * `s`  Telescope git status
  * `g`  open Neogit; [README](https://github.com/TimUntersberger/neogit)
* `,h` help
* `,r` vim-test
* `,h` show line diagnostics
* `C-n|p` (command mode) jump to next|previous lsp diagnostics


### Movement and others

* `tab, S-tab` switch buffers (close with `,q`)
* `s`       [leap.nvim](https://github.com/ggandor/leap.nvim);  like 'f', but multiple lines; `gs` to jump to other splits
* `,a =`    align line/selection by `=`; [vim-easy-align](https://github.com/junegunn/vim-easy-align)
  * to align markdown tables, try `,a | ** <cr>` :sparkles:
* `,d`      toggle nvim-tree; [bindings](https://github.com/kyazdani42/nvim-tree.lua#keybindings); `I` to toggle gitignore'd files
* `,u`      toggle UndoTree
* `gcc`     toggle comment on/off
* `kj`      remap of ESC
* `<space> l` clear search highlight
* `,te`     toggle terminal; `:ToggleTermSendCurrentLine` and other goodies, see [README](https://github.com/akinsho/toggleterm.nvim)


### Marks
* `ma`        set mark `a`; [README](https://github.com/chentau/marks.nvim)
* `m:a`       preview mark `a`
* `dm-`       delete all marks in current line
* `dm<space>` delete all marks in current buffer


### Snippets

* `C-p|n`  cycle through elements
* `C-d|b`  jump to next/previous placeholder


## Workflows

### Search and Replace

Search and replace is like nothing you've ever experienced, thanks to `Telescope` and `quickfix-reflector`. Ok, let's say you want to replace the function `foo` with `bar` in some files in the project. Watch this:

- search for string: `,s` to open Telescope live_grep, then enter `foo`
- put those results into the quickfix list with `<c-q>` ([watch this](https://www.youtube.com/watch?v=IoyW8XYGqjM) if you have no idea what the quickfix list is; send all __selected items__ to qflist with `<m-q>` btw.)
- now, edit the contents in the quickfix list! optionally remove lines you don't want to replace, then some kind of: `:s/foo/bar/g`. We even get a preview of our replacement.
- if we're happy, `:w`rite the changes


### Markdown

* `:Toc`  display table of contents
* `zm, zO, ...`  usual folding syntax
*  fenced code blocks


## Misc

### Terminal
The [colorscheme](https://github.com/folke/tokyonight.nvim) and other goodies require a terminal with truecolor support. Sadly, that isn't the case for MacOS' Terminal. Currently I'm mostly using [iTerm2](https://iterm2.com).

### Fonts
For all the icons to show correctly, please use one of the [Nerd Fonts](https://www.nerdfonts.com). __However__, there's also a __Lo-Fi mode/style__ available, which transparently removes all Nerdfont/Devicon requirements :sparkles: To use, just set the env var `NVIM_STYLE=plain` before calling this neovim config.

