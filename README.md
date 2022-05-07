> a __modern__ and __highly opinionated__ lua config for neovim 0.7+

## Features

- nvim 0.7+ lua-based config
- complete package with useful plugins, bindings and colorschemes
- fully portable; place this repo anywhere you want
- modern telescope and lsp setup
- nicely structured and fine-tuned `init.loa` config for easy extension/modification
- enhanced markdown editing with folding, fenced code hightighting and TOC
- trailing whitespace on save are automatically removed
- regex commands (like search/replace) with live preview
- smart text objects: select text, then use `.` to enlage selection
- manage git repo with [neogit](https://github.com/TimUntersberger/neogit)
- collab editing with [instant](https://github.com/jbyuki/instant.nvim)
- [which-key](https://github.com/folke/which-key.nvim): displays a popup with possible keybindings of the command you started typing

If you need something established and well maintained, backed by a large community to answer your questions, I recommend checking out:
- [AstroVim](https://astronvim.github.io)
- [Nvchad](https://nvchad.github.io)


## Installation

### self-contained/portable usage

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

## Bindings

Here's a list of some useful keyboard bindings. To get an overview and search trough them, use the `:Telescope keymaps` command.


### Finding stuff with Telescope

* `<leader> f` git_files || find_files
* `<leader> g` git_files
* `<leader> s` live_grep ("search")
* `<leader> b` buffers
* `<leader> ta` tags
* `<leader> th` help_tags
* `<leader> to` todos
* `<leader><space>` find in current buffer

[Telescope bindings](https://github.com/nvim-telescope/telescope.nvim#mappings) to select/open files (same for nvim-tree):

* `<c-n|p>` movement
* `<c-t>`   open in tab
* `<c-v>`   open in vertical split
* `<c-x>`   open in horizontal split


### lsp Helpers

* `gh`   find element
* `gd`   go to definition
* `gD`   go to Declaration
* `gi`   go to implemention
* `K`    show docs
* `gr`   go to references
* `gd`   preview definition
* `gs`   show signatur help
* `gp`   go to preview actions
* `<leader>c` code actions; `a` action, `r` rename, `s` reformat file
* `<leader>t` telescope stuff
* `<leader>g` git actions
* `<leader>h` help
* `<leader>r` vim-test
* `<space> h` show line diagnostics
* `ctrl-n|p` jump to next|previous lsp diagnostics
* `,s`   fix **s**tyle (format) current file


### Movement and others

* `tab, S-tab` switch buffers (close with `,q`)
* `s`       [leap.nvim](https://github.com/ggandor/leap.nvim);  like 'f', but multiple lines; `sab`
* `,a =`    align line/selection
* `,d`      toggle nvim-tree; [bindings](https://github.com/kyazdani42/nvim-tree.lua#keybindings)
* `,u`      toggle UndoTree
* `,tr`     toggle Trouble diagnostics
* `,w`      toggle distraction-free writing
* `gcc`     toggle comment on/off
* `,c`      open Neogit
* `kj`      remap of ESC
* `<space> l` clear search highlight
* `F9`      toggle paste/nopaste
* `F10`     toggle number/nonumber
* `,te`     toggle terminal
* `,tt`     open Vista nvim_lsp symbols
* `:GitBlameToggle`  show git blame info


### Snippets

* `ctrl-p | ctrl-n`  cycle through elements
* `ctrl-j`           complete snippet


### Fugitive

Browse the git histroy with style. [Docs](https://github.com/tpope/vim-fugitive), [screencast](http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/).

* `:Gdiff`    show diff
* `:Gstatus`  toggle files with `-`
* `:Glog -- %` load all commits which touched current file to quickfix list
* `:Glog --grep=findme` search for 'findme' in all ancestral commit messages
* `:Glog -Sfindme` search for 'findme' in the diff


## Workflows

### Search and Replace

Search and replace is like nothing you've ever experienced, thanks to `Telescope` and `quickfix-reflector`. Ok, let's say you want to replace the function `foo` with `bar` in some files in the project. Watch this:

- search for string: `<space> s` to open Telescope live_grep, then enter `foo`
- put those results into the quickfix list with `<ctrl> q` ([watch this](https://www.youtube.com/watch?v=IoyW8XYGqjM) if you have no idea what the quickfix list is)
- now, edit the contents in the quickfix list! optionally remove lines you don't want to replace, then some kind of: `:s/foo/bar/g`. We even get a preview of our replacement.
- if we're happy, `:w`rite the changes


### Markdown

* `:Toc`  display table of contents
* `zm, zO, ...`  usual folding syntax
*  fenced code blocks


## Misc

### Fonts
For all the icons to show correctly, please use one of the [Nerd Fonts](https://www.nerdfonts.com).

