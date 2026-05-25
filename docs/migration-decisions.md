# Migration Decisions

This records how plugins from `prev_cfg/` map into the current LazyVim-based
configuration. The goal is to keep the active TODO queue small while preserving
why older plugins were migrated, replaced, deferred, or omitted.

## Migrated Directly

| Previous plugin | Current location | Decision |
| --- | --- | --- |
| `nvim-telescope/telescope.nvim` | `lua/plugins/telescope.lua` | Kept for file, grep, buffer, help, colorscheme, and symbol pickers. |
| `nvim-telescope/telescope-fzf-native.nvim` | `lua/plugins/telescope.lua` | Kept as an optional native Telescope sorter. |
| `folke/which-key.nvim` | `lua/plugins/which-key.lua` | Kept through LazyVim with local group additions only. |
| `akinsho/toggleterm.nvim` | `lua/plugins/toggleterm.lua` | Kept for terminal and lazygit workflows. |
| `beauwilliams/focus.nvim` | `lua/plugins/focus.lua` | Kept for automatic split resizing. |
| `tpope/vim-repeat` | `lua/plugins/vim-repeat.lua` | Kept for repeatable plugin actions. |
| `sickill/vim-pasta` | `lua/plugins/vim-pasta.lua` | Kept for indentation-aware paste behavior. |
| `stefandtw/quickfix-reflector.vim` | `lua/plugins/quickfix-reflector.lua` | Kept for quickfix editing workflows. |
| `abecodes/tabout.nvim` | `lua/plugins/tabout.lua` | Kept for tabbing out of pairs in insert mode. |
| `samjwill/nvim-unception` | `lua/plugins/nvim-unception.lua` | Kept for terminal Neovim nesting behavior. |
| `tpope/vim-fugitive` | `lua/plugins/fugitive.lua` | Kept for Git command integration inside Neovim. |
| `tpope/vim-dispatch` | `lua/plugins/dispatch.lua` | Kept for async build and command dispatch workflows. |
| `arcticicestudio/nord-vim` | `lua/plugins/colorschemes.lua` | Kept as an available colorscheme. |
| `catppuccin/nvim` | `lua/plugins/colorschemes.lua` | Kept as an available colorscheme family. |
| `rebelot/kanagawa.nvim` | `lua/plugins/colorschemes.lua` | Kept as an available colorscheme family. |

## Replaced

| Previous plugin | Replacement | Decision |
| --- | --- | --- |
| `numToStr/Comment.nvim` | `mini.comment` | Use LazyVim's Mini extra instead of a separate commenting plugin. |
| `kylechui/nvim-surround` | `mini.surround` | Use LazyVim's Mini extra for surround editing. |
| `windwp/nvim-autopairs` | `mini.pairs` | Use LazyVim's default Mini pairs integration. |
| `famiu/bufdelete.nvim` | `mini.bufremove` | Use Mini buffer removal and keep `<leader>q`. |
| `ggandor/leap.nvim`, `ggandor/flit.nvim` | `mini.jump` | Use Mini motions for the current baseline. |
| `hoob3rt/lualine.nvim` | `mini.statusline` | Prefer the smaller Mini statusline. |
| `kdheepak/tabline.nvim` | `mini.tabline` | Prefer the smaller Mini tabline. |
| `RRethy/vim-illuminate` | `mini.cursorword` | Use Mini word highlighting. |
| `lukas-reineke/indent-blankline.nvim` | `mini.indentscope` | Use Mini indentation scope highlighting. |
| `lewis6991/gitsigns.nvim` | `mini.diff` | Use Mini diff signs and overlays for the baseline. |
| `jiaoshijie/undotree` | Neovim 0.12 `nvim.undotree` | Use the native optional package loaded on demand. |
| `nvim-tree/nvim-tree.lua` | Snacks explorer | Use LazyVim's built-in Snacks explorer baseline, with `<leader>d` and `mf` preserving the old directory/reveal workflows. |
| `LuaSnip` and completion snippet glue | `mini.snippets` | Use LazyVim's Mini snippet extra for this baseline. |
| `neovim/nvim-lspconfig` | Native `vim.lsp` | Define and enable local LSP servers in `lua/config/lsp.lua`. |
| `solargraph`, `standardrb` LSP setup | Shopify `ruby-lsp` | Use Ruby LSP with Standard formatter/linter init options. |

## Covered By LazyVim Baseline

| Previous plugin | Current source | Decision |
| --- | --- | --- |
| `folke/lazy.nvim` | `lua/config/lazy.lua` | Bootstrapped by the LazyVim starter flow. |
| `folke/tokyonight.nvim` | LazyVim core | Keep LazyVim's default colorscheme available. |
| `nvim-lua/plenary.nvim` | Dependencies | Pulled by plugins that need it. |
| `nvim-tree/nvim-web-devicons` | LazyVim/Mini icons | Avoid adding a separate icon layer unless needed later. |
| `nvim-treesitter/nvim-treesitter` | LazyVim core | Keep parser management in the LazyVim baseline. |
| `nvim-treesitter/nvim-treesitter-context` | LazyVim UI extra | Enabled for sticky code context headers. |
| `hrsh7th/nvim-cmp` and cmp sources | LazyVim core | Replaced by LazyVim's completion baseline, currently `blink.cmp`. |

## Omitted For Now

| Previous plugin | Reason |
| --- | --- |
| `stevearc/dressing.nvim` | LazyVim/Snacks already provides UI integration points; revisit only if a workflow needs Dressing behavior specifically. |
| `folke/todo-comments.nvim` | Not needed in the current baseline. |
| `sindrets/diffview.nvim` | Mini diff and Fugitive cover the current Git baseline. |
| `levouh/tint.nvim` | Focused window behavior is covered by `focus.nvim`; inactive dimming is omitted. |
| `nacro90/numb.nvim` | Line preview behavior is omitted. |
| `HampusHauffman/block.nvim` | Block highlighting is omitted until a concrete editing need returns. |
| `rmagatti/goto-preview` | LazyVim LSP navigation is the current baseline. |
| `onsails/lspkind-nvim`, `j-hui/fidget.nvim` | Omitted until LSP UI needs are re-evaluated against LazyVim/Snacks. |
| `norcalli/nvim-colorizer.lua` | Omitted until color preview support is explicitly needed. |
| `xorid/asciitree.nvim` | Omitted until ASCII tree generation is actively needed. |
| `smjonas/live-command.nvim` | Omitted until live preview commands are actively needed. |
| `nvim-neotest/neotest`, `olimorris/neotest-rspec` | Omitted until the test workflow is redefined for the LazyVim baseline. |
| `ThePrimeagen/refactoring.nvim` | Omitted until refactoring workflows are reintroduced deliberately. |
| `simrat39/symbols-outline.nvim` | LazyVim symbol navigation is the current baseline. |
| `cshuaimin/ssr.nvim` | Omitted until structural search and replace is actively needed. |
| `fatih/vim-go`, `simrat39/rust-tools.nvim`, `PedramNavid/dbtpal` | Language-specific plugins are deferred; baseline LSP now uses native `vim.lsp` with external binaries. |
| `mfussenegger/nvim-dap` | Debugging is deferred until debugger adapters are supplied outside Mason. |
| `nvimtools/none-ls.nvim`, `nvimtools/none-ls-extras.nvim` | Formatting and linting are deferred until external tools are selected outside Mason. |
| Additional old colorschemes | Only `tokyonight`, `nord`, `catppuccin`, and `kanagawa` are kept in the baseline. |

## Deferred

| Plugin | Reason |
| --- | --- |
| `folke/sidekick.nvim` | Deferred until Copilot LSP and desired AI CLI binaries are configured outside Mason. |
