# Plugin Inventory

This config uses `lazy.nvim`. The primary plugin specification is in
[`../init.lua`](../init.lua), with module-level setup in [`../lua/sohooo/`](../lua/sohooo/).
Pinned versions are recorded in [`../lazy-lock.json`](../lazy-lock.json).

## Plugin Manager

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/lazy.nvim` | `init.lua` bootstrap block | Plugin manager and lazy-loading runtime. | Installed automatically into Neovim's data directory if missing. |

## Search And Navigation

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `nvim-telescope/telescope.nvim` | `init.lua`, `lua/sohooo/telescope.lua`, `lua/sohooo/which-key.lua` | Fuzzy finder for files, buffers, help, symbols, grep, commands, and other pickers. | Uses custom picker mappings and leader keymaps. |
| `nvim-telescope/telescope-fzf-native.nvim` | `init.lua` | Native FZF sorter for Telescope. | Built with `make` when available. |
| `nvim-lua/plenary.nvim` | dependency in `init.lua` | Lua utility library used by several plugins. | Dependency for Telescope, gitsigns, neotest, undotree, and others. |
| `ggandor/leap.nvim` | `init.lua` | Fast cursor jumping. | Default keymaps are enabled in `init.lua`. |
| `ggandor/flit.nvim` | `init.lua` inline config | Enhanced `f`/`t` motions integrated with Leap. | Setup uses defaults. |
| `nacro90/numb.nvim` | `init.lua` | Peeks target lines while entering line numbers. | Setup uses defaults. |
| `rmagatti/goto-preview` | `init.lua`, `lua/sohooo/which-key.lua` | Floating preview windows for LSP definitions, implementations, and references. | Used by `gd`, `gi`, `gr`, and `gp*` maps. |
| `simrat39/symbols-outline.nvim` | `init.lua` inline config | Symbol outline sidebar. | Loaded by `:SymbolsOutline`; mapped to `<leader>cs`. |

## UI And Layout

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/which-key.nvim` | `init.lua`, `lua/sohooo/which-key.lua` | Displays available keybindings while typing key sequences. | Main source of custom keymaps. |
| `stevearc/dressing.nvim` | `init.lua` | Improves `vim.ui.select` and `vim.ui.input` interfaces. | No custom setup. |
| `hoob3rt/lualine.nvim` | `init.lua`, `lua/sohooo/lualine.lua` | Statusline. | Theme follows `MyColors()`. |
| `kdheepak/tabline.nvim` | `init.lua`, `lua/sohooo/lualine.lua` | Buffer and tab display. | Integrated with lualine config. |
| `kyazdani42/nvim-web-devicons` | `init.lua` | Filetype and plugin icons. | Disabled visually when `NVIM_STYLE=plain`. |
| `nvim-tree/nvim-tree.lua` | `init.lua`, `lua/sohooo/nvim-tree.lua`, `lua/sohooo/which-key.lua` | File explorer. | Custom open mappings are set in `on_attach`. |
| `HampusHauffman/block.nvim` | `init.lua` inline config | Visual code block highlighting. | Mapped to `<leader>cb`. |
| `lukas-reineke/indent-blankline.nvim` | `init.lua` | Indentation guides. | Loaded as `ibl`; setup uses defaults. |
| `levouh/tint.nvim` | `init.lua` | Dims inactive windows. | Setup uses defaults. |
| `beauwilliams/focus.nvim` | `init.lua`, `lua/sohooo/focus.lua` | Auto-resizes focused splits. | Disabled for tree/prompt-like buffers. |
| `folke/todo-comments.nvim` | `init.lua`, `lua/sohooo/todo-comments.lua` | Highlights and searches TODO-style comments. | Uses wide background highlighting. |

## Git And Diff

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `tpope/vim-fugitive` | `init.lua` | Git commands inside Neovim. | Provides `:Git` and related commands. |
| `lewis6991/gitsigns.nvim` | `init.lua`, `lua/sohooo/gitsigns.lua` | Git signs, hunk metadata, and current-line blame. | Includes optional yadm worktree support. |
| `sindrets/diffview.nvim` | `init.lua`, `lua/sohooo/which-key.lua` | Git diff and file history views. | Mapped under `<leader>v`. |
| `akinsho/toggleterm.nvim` | `init.lua`, `lua/sohooo/toggleterm.lua`, `lua/sohooo/which-key.lua` | Terminal management. | Used for `<leader>te`, test strategy, and lazygit floating terminal. |

## Editing

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `numToStr/Comment.nvim` | `init.lua` | Comment toggling. | Setup uses defaults, including `gcc` and visual mappings. |
| `tpope/vim-repeat` | `init.lua` | Makes supported plugin actions repeatable with `.`. | No custom setup. |
| `sickill/vim-pasta` | `init.lua` | Smarter indentation while pasting. | No custom setup. |
| `stefandtw/quickfix-reflector.vim` | `init.lua` | Edit quickfix entries and write changes back to files. | Useful with Telescope live grep workflows. |
| `windwp/nvim-autopairs` | `init.lua` | Automatic bracket and quote pairing. | Setup uses defaults. |
| `abecodes/tabout.nvim` | `init.lua` | Tab out of quotes/brackets. | Setup uses defaults. |
| `RRethy/vim-illuminate` | `init.lua` | Highlights references to the word under the cursor. | No custom setup. |
| `jiaoshijie/undotree` | `init.lua`, `lua/sohooo/which-key.lua` | Undo history tree. | Mapped to `<leader>u`. |
| `echasnovski/mini.align` | `init.lua` | Interactive alignment. | Setup uses defaults. |
| `smjonas/live-command.nvim` | `init.lua` inline config | Live preview for selected Ex commands. | Adds previewable `:Norm`. |
| `kylechui/nvim-surround` | `init.lua` inline config | Add, change, and delete surrounding delimiters. | Setup uses defaults. |
| `ThePrimeagen/refactoring.nvim` | `init.lua`, `lua/sohooo/which-key.lua` | Refactoring actions. | Visual selection refactor mapped to `<leader>cv`. |
| `cshuaimin/ssr.nvim` | `init.lua` inline config | Structural search and replace. | Mapped to `<leader>cR`. |

## Language, LSP, Completion, And Tests

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `nvim-treesitter/nvim-treesitter` | `init.lua` | Parser-based syntax highlighting and code navigation foundation. | Uses `main` branch and `:TSUpdate` build. |
| `neovim/nvim-lspconfig` | `init.lua`, `lua/sohooo/lsp.lua` | Built-in LSP client server configuration. | Configures Go, Puppet, Ruff, Rust, Ruby, Lua, and related servers when installed. |
| `hrsh7th/nvim-cmp` | `init.lua`, `lua/sohooo/lsp.lua` | Completion engine. | Uses bordered completion and documentation windows. |
| `hrsh7th/cmp-buffer` | `init.lua`, `lua/sohooo/lsp.lua` | Buffer completion source for `nvim-cmp`. | Enabled with minimum keyword length 3. |
| `hrsh7th/cmp-path` | `init.lua`, `lua/sohooo/lsp.lua` | Path completion source for `nvim-cmp`. | Enabled. |
| `hrsh7th/cmp-nvim-lsp` | `init.lua`, `lua/sohooo/lsp.lua` | LSP completion source and capabilities for `nvim-cmp`. | Extends LSP capabilities. |
| `hrsh7th/cmp-nvim-lua` | `init.lua` | Neovim Lua completion source. | Declared as plugin. |
| `saadparwaiz1/cmp_luasnip` | `init.lua`, `lua/sohooo/lsp.lua` | LuaSnip completion source. | Enabled with minimum keyword length 2. |
| `L3MON4D3/LuaSnip` | `init.lua`, `lua/sohooo/lsp.lua` | Snippet engine. | Loads VS Code-style snippets lazily. |
| `rafamadriz/friendly-snippets` | `init.lua`, `lua/sohooo/lsp.lua` | Community snippet collection. | Loaded through LuaSnip. |
| `onsails/lspkind-nvim` | `init.lua`, `lua/sohooo/lsp.lua` | Adds completion kind labels/icons. | Switches to text mode when `NVIM_STYLE=plain`. |
| `j-hui/fidget.nvim` | `init.lua` | LSP progress UI. | Done messages remain for 6 seconds. |
| `nvimtools/none-ls.nvim` | `init.lua`, `lua/sohooo/null-ls.lua` | Exposes external linters, formatters, and code actions through LSP. | Configures shellcheck, sqlfluff, yamllint, stylua, shfmt, and others. |
| `nvimtools/none-ls-extras.nvim` | `init.lua` | Extra none-ls sources. | Declared as dependency. |
| `nvim-neotest/neotest` | `init.lua`, `lua/sohooo/neotest.lua`, `lua/sohooo/which-key.lua` | Test runner framework. | Configured for RSpec. |
| `nvim-neotest/nvim-nio` | `init.lua` dependency | Async IO dependency for neotest. | Dependency only. |
| `antoinemadec/FixCursorHold.nvim` | `init.lua` dependency | CursorHold compatibility helper for neotest. | Dependency only. |
| `olimorris/neotest-rspec` | `init.lua`, `lua/sohooo/neotest.lua` | RSpec adapter for neotest. | Runs `bin/rspec`. |
| `mfussenegger/nvim-dap` | `init.lua` | Debug Adapter Protocol client. | Declared but not configured here. |
| `simrat39/rust-tools.nvim` | `init.lua`, `lua/sohooo/rust-tools.lua` | Rust LSP extensions and inlay hints. | Inlay hints enabled. |
| `fatih/vim-go` | `init.lua`, `lua/sohooo/misc.lua` | Go language support. | Uses `gopls` imports and format-on-save settings. |
| `rodjek/vim-puppet` | `init.lua` | Puppet syntax and language support. | Complements Puppet LSP and linting. |
| `PedramNavid/dbtpal` | `init.lua` | dbt workflow helpers. | Declared but not configured here. |

## Helpers And Miscellaneous

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `xorid/asciitree.nvim` | `init.lua` | Generates ASCII trees. | Provides `:AsciiTree`. |
| `samjwill/nvim-unception` | `init.lua` | Prevents nested Neovim sessions when opening files from terminal Neovim. | No custom setup. |
| `famiu/bufdelete.nvim` | `init.lua`, `lua/sohooo/which-key.lua` | Deletes buffers without closing windows. | Mapped to `<leader>q`. |
| `norcalli/nvim-colorizer.lua` | `init.lua` | Highlights color literals. | Enabled only in hi-fi mode. |

## Colorschemes

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `arcticicestudio/nord-vim` | `init.lua` | Nord colorscheme. | Used in plain mode fallback and optional user style. |
| `catppuccin/nvim` | `init.lua` | Catppuccin colorscheme collection. | Installed as `catppuccin`. |
| `nyoom-engineering/oxocarbon.nvim` | `init.lua` | Oxocarbon colorscheme. | Optional. |
| `navarasu/onedark.nvim` | `init.lua` | One Dark colorscheme. | Optional. |
| `PHSix/nvim-hybrid` | `init.lua` | Hybrid colorscheme. | Optional. |
| `rmehri01/onenord.nvim` | `init.lua` | OneNord colorscheme. | Optional. |
| `AlexvZyl/nordic.nvim` | `init.lua` | Nordic colorscheme. | Optional. |
| `shaunsingh/moonlight.nvim` | `init.lua` | Moonlight colorscheme. | Optional. |
| `shaunsingh/doom-vibrant.nvim` | `init.lua` | Doom Vibrant colorscheme. | Optional. |
| `folke/tokyonight.nvim` | `init.lua` | Tokyo Night colorscheme. | Default theme. |
| `rebelot/kanagawa.nvim` | `init.lua` | Kanagawa colorscheme. | Optional. |
| `diegoulloao/neofusion.nvim` | `init.lua` | Neofusion colorscheme. | Optional. |

## Disabled Or Commented Plugin Specs

These plugins are present only as disabled or commented configuration and are not
part of the active runtime baseline:

- `folke/noice.nvim`
- `MunifTanjim/nui.nvim`
- `rcarriga/nvim-notify`
- `folke/neodev.nvim` (`enabled = false`)
- `JoosepAlviste/nvim-ts-context-commentstring`
- `RRethy/nvim-treesitter-textsubjects`
- `RRethy/nvim-treesitter-endwise`
- `romgrk/nvim-treesitter-context`
- `ckolkey/ts-node-action`
- `windwp/nvim-ts-autotag`
- `p00f/nvim-ts-rainbow`

