# Migration Decisions

This records how plugins from `prev_cfg/` map into the current LazyVim-based
configuration. The goal is to keep the active TODO queue small while preserving
why older plugins were migrated, replaced, deferred, or omitted.

## Migrated Directly

| Previous plugin | Current location | Decision |
| --- | --- | --- |
| `folke/which-key.nvim` | `lua/plugins/which-key.lua` | Kept through LazyVim with local group additions only. |
| LazyVim/Snacks picker keymaps | `lua/plugins/pickers.lua` | Moved broad LazyVim picker families to `,p` while preserving immediate `,f`, `,b`, and `,s` picker actions. |
| Snacks terminal keymaps | `lua/plugins/snacks-terminal.lua` | Preserves terminal and lazygit workflows on `,te`, `,tt`, and `,tg`. |
| `stefandtw/quickfix-reflector.vim` | `lua/plugins/quickfix-reflector.lua` | Kept for quickfix editing workflows. |
| `samjwill/nvim-unception` | `lua/plugins/nvim-unception.lua` | Kept for terminal Neovim nesting behavior. |
| `tpope/vim-fugitive` | `lua/plugins/fugitive.lua` | Kept for Git command integration inside Neovim. |
| `tpope/vim-dispatch` | `lua/plugins/dispatch.lua` | Kept for async build and command dispatch workflows. |
| `MyColors()` | `lua/config/theme.lua` | Migrated to a LazyVim-compatible profile module selected by `GIT_USERNAME`. |
| `arcticicestudio/nord-vim` | `lua/plugins/colorschemes.lua` | Kept as an available colorscheme. |
| `catppuccin/nvim` | `lua/plugins/colorschemes.lua` | Kept as an available colorscheme family. |
| `rebelot/kanagawa.nvim` | `lua/plugins/colorschemes.lua` | Kept as an available colorscheme family. |

## Replaced

| Previous plugin | Replacement | Decision |
| --- | --- | --- |
| `numToStr/Comment.nvim` | `mini.comment` | Use LazyVim's Mini extra instead of a separate commenting plugin. |
| `kylechui/nvim-surround` | `mini.surround` | Use LazyVim's Mini extra for surround editing. |
| `windwp/nvim-autopairs` | `mini.pairs` | Use LazyVim's default Mini pairs integration. |
| `famiu/bufdelete.nvim` | `Snacks.bufdelete()` | Use LazyVim's built-in buffer deletion path and keep `,q`. |
| `ggandor/leap.nvim`, `ggandor/flit.nvim` | `mini.jump` | Use Mini motions for the current baseline. |
| `hoob3rt/lualine.nvim` | LazyVim `lualine.nvim` | Restore LazyVim's statusline default instead of a local Mini statusline. |
| `kdheepak/tabline.nvim` | LazyVim `bufferline.nvim` | Restore LazyVim's bufferline default and move local buffer actions under `,B`. |
| `RRethy/vim-illuminate` | `Snacks.words` | Use LazyVim's word reference highlighting/navigation. |
| `lukas-reineke/indent-blankline.nvim` | LazyVim/Snacks indent behavior | Use LazyVim's current indent baseline instead of Mini indentscope. |
| `lewis6991/gitsigns.nvim` | LazyVim `gitsigns.nvim` | Restore LazyVim's default Git signs and hunk actions. |
| `jiaoshijie/undotree` | Neovim 0.12 `nvim.undotree` | Use the native optional package loaded on demand. |
| `nvim-tree/nvim-tree.lua` | Snacks explorer | Use LazyVim's built-in Snacks explorer baseline, with `,d` and `mf` preserving the old directory/reveal workflows. |
| `LuaSnip` and completion snippet glue | `mini.snippets` | Use LazyVim's Mini snippet extra for this baseline. |
| `neovim/nvim-lspconfig` | Native `vim.lsp` | Define and enable local LSP servers in `lua/config/lsp.lua`. |
| `solargraph`, `standardrb` LSP setup | Shopify Ruby LSP | Ruby uses `ruby-lsp` directly from `PATH` through native `vim.lsp`. Formatting and linting use Ruby LSP project defaults for now. |
| `nvim-telescope/telescope.nvim`, `telescope-fzf-native.nvim` | Snacks picker | Use LazyVim's picker stack while preserving old short bindings. |
| `akinsho/toggleterm.nvim` | Snacks terminal | Use LazyVim's terminal stack while preserving local terminal/lazygit keys. |

## Covered By LazyVim Baseline

| Previous plugin | Current source | Decision |
| --- | --- | --- |
| `folke/lazy.nvim` | `lua/config/lazy.lua` | Bootstrapped by the LazyVim starter flow. |
| `folke/tokyonight.nvim` | LazyVim core | Keep LazyVim's default colorscheme available. |
| `nvim-lua/plenary.nvim` | Dependencies | Pulled by plugins that need it. |
| `nvim-tree/nvim-web-devicons` | LazyVim/Mini icons | Avoid adding a separate icon layer unless needed later. |
| `nvim-treesitter/nvim-treesitter` | LazyVim core | Keep parser management in the LazyVim baseline. |
| `nvim-treesitter/nvim-treesitter-context` | LazyVim UI extra | Enabled for sticky code context headers. |
| `folke/todo-comments.nvim` | LazyVim core with `lua/plugins/pickers.lua` key overrides | Keep LazyVim's TODO/FIX/FIXME indexing and move picker mappings under `,ps`. |
| `hrsh7th/nvim-cmp` and cmp sources | LazyVim core | Replaced by LazyVim's completion baseline, currently `blink.cmp`. |
| `nvim-lualine/lualine.nvim` | LazyVim core | Restored as the default statusline. |
| `akinsho/bufferline.nvim` | LazyVim core with `lua/plugins/bufferline.lua` overrides | Restored as the default bufferline with local `,B` remaps. |
| `lewis6991/gitsigns.nvim` | LazyVim core | Restored as the default Git signs integration. |

## Omitted For Now

| Previous plugin | Reason |
| --- | --- |
| `stevearc/dressing.nvim` | LazyVim/Snacks already provides UI integration points; revisit only if a workflow needs Dressing behavior specifically. |
| `sindrets/diffview.nvim` | Gitsigns and Fugitive cover the current Git baseline. |
| `levouh/tint.nvim` | LazyVim/Snacks window tools cover the current focus baseline; inactive dimming is omitted. |
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

## Removed After Overlap Review

| Removed plugin | Replacement | Reason |
| --- | --- | --- |
| `nvim-telescope/telescope.nvim` | Snacks picker | Avoid a second picker stack while preserving the old short picker keys. |
| `nvim-telescope/telescope-fzf-native.nvim` | Snacks picker | Telescope-specific sorter no longer needed. |
| `akinsho/toggleterm.nvim` | Snacks terminal | LazyVim already ships terminal helpers through Snacks. |
| `beauwilliams/focus.nvim` | LazyVim window tools | Removed adjacent layout behavior to stay closer to LazyVim defaults. |
| `abecodes/tabout.nvim` | Mini pairs and default insert-mode behavior | Removed insert-mode mapping overlap. |
| `sickill/vim-pasta` | Neovim/LazyVim paste behavior | Removed legacy paste override until a concrete paste issue returns. |
| `tpope/vim-repeat` | Native/LazyVim plugin behavior | Removed low-signal compatibility plugin with no current mapped workflow. |
| `nvim-mini/mini.bufremove` | `Snacks.bufdelete()` | Avoid duplicate buffer deletion implementation. |
| `nvim-mini/mini.statusline` | `lualine.nvim` | Prefer LazyVim's default statusline. |
| `nvim-mini/mini.tabline` | `bufferline.nvim` | Prefer LazyVim's default bufferline. |
| `nvim-mini/mini.diff` | `gitsigns.nvim` | Prefer LazyVim's default Git signs integration. |
| `nvim-mini/mini.cursorword` | `Snacks.words` | Prefer LazyVim's default word reference behavior. |
| `nvim-mini/mini.cmdline` | Noice/LazyVim UI | Avoid overlapping command-line UI layers. |
| `nvim-mini/mini.indentscope` | Snacks/LazyVim indent behavior | Avoid duplicate scope/indent visuals. |

## Deferred

| Plugin | Reason |
| --- | --- |
| AI assistant plugin | No active plugin yet. Prefer a small Crush terminal integration next; keep CodeCompanion and Parrot as future candidates. Node-required AI plugins are out of scope. |
