> my __highly opinionated__ Neovim 0.10+ Lua config

## Features

- modern nvim 0.10+ lua-based config with [lazy.nvim](https://github.com/folke/lazy.nvim#-performance) package manager, [telescope](https://github.com/nvim-telescope/telescope.nvim) and LSP configured via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- complete package with useful plugins, autocommands, bindings and colorschemes
- fully portable; place this repo anywhere you want (see below)
- nicely structured and fine-tuned `init.lua` config
- [which-key](https://github.com/folke/which-key.nvim): displays a popup with possible keybindings of the command you started typing
- enhanced markdown editing with folding, fenced code highlighting and TOC
- regex commands (like search/replace) with live preview; change directly in quickfix list
- smart text objects: select text, then use `.` to enlarge selection

- optional lo-fi mode without Nerd Font icons via `NVIM_STYLE=plain`

__Note:__ if you need something established and well maintained, backed by a large community to answer your questions, I highly recommend checking out:
- [AstroVim](https://astronvim.github.io)
- [LunarVim](https://github.com/ChristianChiarulli/LunarVim)
- [Nvchad](https://nvchad.github.io)


## Installation

First, you need to [install Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim). Then, follow one of the following methods:
- __default location__: follow `XDG` env conventions and put this config in `~/.config` to have `./config/nvim`
- __portable/custom location__: custom location for this config by setting `XDG` env vars; see [PORTABLE.md](PORTABLE.md)

```bash
cd
mkdir .config; cd $_
test -d nvim && mv -v nvim nvim.bck # save existing config
git clone https://github.com/sohooo/nvim.git
nvim
# plugin installation; see below
```

### Plugins

This config uses [lazy.nvim](https://github.com/folke/lazy.nvim#-performance) to manage Neovim plugins:

```bash
# start nvim using this config
# this will install all plugins
nvim

# restart nvim, then check if everything's there :)
:Lazy            # plugins
:TSInstallInfo   # Treesitter grammars
```

LSP servers, linters and formatters are not installed automatically. Install them with your system package manager so they are available on `$PATH`.

### Updating plugins

Helper scripts are provided to update and verify plugins:

```bash
./scripts/update-plugins.sh   # upgrade plugins via lazy.nvim
./scripts/verify-plugins.sh   # run headless test after updates
```

## Bindings

Here's a list of some useful keymaps. Just start typing and wait for the context-sensitive `which-key` popup. Try it with `,` (the Leader key) and wait to see further options. Alternatively, search through them with Legendary by hitting `, <space>`.

### Finding stuff with Telescope

* `,f` find_files ([ripgrep](https://github.com/BurntSushi/ripgrep) highly recommended)
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
* `ga | gA`   align | with preview
  * e.g.: to align markdown tables: `gA | <cr>` :sparkles:
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
* `<cr> / <bs>` exand / shrink selection (in normal mode)
* `s`       [leap.nvim](https://github.com/ggandor/leap.nvim);  like 'f', but multiple lines; `gs` to jump to other splits
* `,d`      toggle nvim-tree; [bindings](https://github.com/kyazdani42/nvim-tree.lua#keybindings); `I` to toggle gitignore'd files
* `,g`      Lazygit floating terminal
* `,u`      toggle UndoTree
* `gcc`     toggle comment on/off
* `kj`      remap of ESC
* `<space> l` clear search highlight
* `<space> k` toggle node action (toogle bools, split/join hashes, ...)
* `,te`     toggle terminal; `:ToggleTermSendCurrentLine` and other goodies, see [README](https://github.com/akinsho/toggleterm.nvim)


### Marks
* `ma`        set mark `a`; [README](https://github.com/chentau/marks.nvim)
* `m:a`       preview mark `a`
* `dm-`       delete all marks in current line
* `dm<space>` delete all marks in current buffer


### Snippets

* `C-p|n`  cycle through elements
* `C-f|b`  jump to next/previous placeholder


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


## Testing

Run `./tests/run.sh` to check the configuration in a headless Neovim instance. The
script exits with an error if any warnings or errors occur.

## Misc

### Terminal
The [colorscheme](https://github.com/folke/tokyonight.nvim) and other goodies require a terminal with truecolor support. Sadly, that isn't the case for MacOS' Terminal. Currently I'm mostly using [iTerm2](https://iterm2.com).

### Fonts
For all the icons to show correctly, please use one of the [Nerd Fonts](https://www.nerdfonts.com). __However__, there's also a __Lo-Fi mode/style__ available, which transparently removes all Nerdfont/Devicon requirements :sparkles: To use, just set the env var `NVIM_STYLE=plain` before calling this neovim config.

