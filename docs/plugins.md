# Plugin Inventory

This config is now based on LazyVim. Local plugin specs are split under
[`../lua/plugins/`](../lua/plugins/), while LazyVim core plugins are imported
from `lazyvim.plugins` in [`../lua/config/lazy.lua`](../lua/config/lazy.lua).
Pinned versions are recorded in [`../lazy-lock.json`](../lazy-lock.json).

## Foundation

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/lazy.nvim` | `lua/config/lazy.lua` | Plugin manager and lazy-loading runtime. | Bootstrapped into the project-local XDG data directory by `scripts/nvim.sh`. |
| `LazyVim/LazyVim` | `lua/config/lazy.lua` | Community-supported Neovim distribution layer. | Provides the base editor, LSP, completion, diagnostics, UI, and keymap conventions. |
| `saghen/blink.cmp` | LazyVim core | Completion engine. | Provides completion capabilities used by native `vim.lsp`; replaces the previous `nvim-cmp` stack. |
| `folke/lazydev.nvim` | LazyVim core | Lua development helper. | Improves Lua library metadata for Neovim config editing. |
| `folke/persistence.nvim` | LazyVim core | Session persistence. | Kept as part of LazyVim's default project/session workflow. |
| `nvim-lua/plenary.nvim` | Dependencies | Lua utility library. | Pulled by plugins that still need it. |
| `neovim/nvim-lspconfig` | `lua/plugins/mason.lua` | Legacy LSP server config collection. | Explicitly disabled. Native `vim.lsp` setup lives in `lua/config/lsp.lua`. |
| `mason-org/mason.nvim` | `lua/plugins/mason.lua` | External tool installer. | Explicitly disabled. Tools must be installed outside this config. |
| `mason-org/mason-lspconfig.nvim` | `lua/plugins/mason.lua` | Mason/LSP bridge. | Explicitly disabled. |
| `jay-babu/mason-nvim-dap.nvim` | `lua/plugins/mason.lua` | Mason/DAP bridge. | Explicitly disabled. |

## Search And Navigation

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/snacks.nvim` explorer | `lua/plugins/snacks-explorer.lua` | File explorer from LazyVim's Snacks baseline. | Mapped to `,d`; `mf` reveals the current file; `o` confirms instead of opening Finder. |
| `folke/snacks.nvim` pickers | `lua/plugins/pickers.lua` | Primary picker stack for files, buffers, grep, help, colorschemes, and symbols. | Keeps `,f`, `,b`, and `,s` as immediate old-config style actions; broader LazyVim picker families live under `,p`. |
| `folke/flash.nvim` | LazyVim core | Jump/search navigation. | Kept as part of the LazyVim baseline. |
| `folke/trouble.nvim` | LazyVim core | Diagnostics, references, symbols, and quickfix views. | Complements Snacks pickers and native LSP navigation. |
| `folke/todo-comments.nvim` | `lua/plugins/pickers.lua` | TODO/FIX/FIXME comment indexing and picker integration. | Provided by LazyVim; local keys move TODO pickers under `,ps`. |
| `nvim-mini/mini.jump` | `lua/plugins/mini.lua` | Enhanced `f`, `F`, `t`, and `T` motions. | Migrated as the Mini replacement for sneak-style movement. |

## UI And Layout

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/which-key.nvim` | `lua/plugins/which-key.lua` | Shows available key sequences while typing. | Adds local comma-leader group metadata. |
| `folke/noice.nvim` | `lua/plugins/pickers.lua` | Command-line, message, and notification UI. | Provided by LazyVim; local keys move Noice actions under `,psn`. |
| `folke/snacks.nvim` scroll | `lua/plugins/snacks.lua` | Smooth scrolling module from Snacks. | Disabled locally so scrolling feels immediate and snappy. |
| `MunifTanjim/nui.nvim` | Dependencies | UI component dependency. | Pulled by LazyVim UI plugins such as Noice. |
| `nvim-treesitter/nvim-treesitter-context` | `lua/plugins/treesitter-context.lua` | Sticky context header for large code blocks. | Imported from LazyVim's UI extra with LazyVim's default toggle. |
| `nvim-lualine/lualine.nvim` | `lua/plugins/bufferline.lua` | Statusline. | LazyVim default layout with theme selected by `lua/config/theme.lua`. |
| `akinsho/bufferline.nvim` | `lua/plugins/bufferline.lua` | Buffer/tab line. | LazyVim default with local `,B` remaps and optional highlights from `lua/config/theme.lua`. |
| `nvim-mini/mini.icons` | LazyVim core | Icon provider. | Already enabled by LazyVim; used instead of adding a separate icon layer. |

## Editing

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `nvim-mini/mini.surround` | `lua/plugins/mini.lua` | Add, delete, and replace surrounding delimiters. | Imported from LazyVim's Mini extra; replaces `nvim-surround`. |
| `nvim-mini/mini.ai` | LazyVim core | Textobjects. | Kept as part of LazyVim's default editing baseline. |
| `nvim-mini/mini.comment` | `lua/plugins/mini.lua` | Comment toggling. | Imported from LazyVim's Mini extra; replaces `Comment.nvim`. |
| `nvim-mini/mini.pairs` | LazyVim core | Automatic bracket and quote pairing. | Replaces `nvim-autopairs`; already enabled by LazyVim. |
| `nvim-mini/mini.align` | `lua/plugins/mini.lua` | Interactive alignment. | Keeps `ga` and `gA` mappings. |
| `nvim-mini/mini.splitjoin` | `lua/plugins/mini.lua` | Toggle between single-line and multi-line forms. | Mapped to `gS`. |
| `nvim-mini/mini.trailspace` | `lua/plugins/mini.lua` | Highlight and trim trailing whitespace. | Trim mapped to `,cw`. |
| `nvim-mini/mini.snippets` | `lua/plugins/mini.lua` | Snippet engine. | Imported from LazyVim's Mini extra; replaces LuaSnip for this baseline. |
| `rafamadriz/friendly-snippets` | LazyVim core | Snippet collection. | Used by the snippet/completion baseline. |
| `MagicDuck/grug-far.nvim` | `lua/plugins/pickers.lua` | Search and replace UI. | LazyVim baseline plugin; local key is moved to `,psr`. |
| `stefandtw/quickfix-reflector.vim` | `lua/plugins/quickfix-reflector.lua` | Edit quickfix entries and write changes back to files. | Kept from the previous config. |
| Native `nvim.undotree` | `lua/config/keymaps.lua` | Neovim 0.12 built-in undo tree viewer. | Loaded on demand with `:packadd nvim.undotree`; mapped to `,u`. |
| `config.style` | `lua/config/style.lua` | Shared local style helper. | Centralizes the `NVIM_STYLE=plain` icon decision used by plugin specs. |

## Git And Terminal

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `lewis6991/gitsigns.nvim` | LazyVim core | Git signs and hunk actions. | Restored as the LazyVim default. |
| `tpope/vim-fugitive` | `lua/plugins/fugitive.lua` | Git command integration inside Neovim. | Loaded on Fugitive commands such as `:Git`; complements lazygit and Gitsigns. |
| `tpope/vim-dispatch` | `lua/plugins/dispatch.lua` | Async build and command dispatcher. | Loaded on Dispatch commands including `:Dispatch`, `:Make`, `:Start`, and vim-dispatch's `:Focus`; no external tool is invoked at startup. |
| `folke/snacks.nvim` terminal | `lua/plugins/snacks-terminal.lua` | Terminal and lazygit workflow. | Replaces the previous terminal plugin while preserving `,te`, `,tt`, and `,tg`. |
| `samjwill/nvim-unception` | `lua/plugins/nvim-unception.lua` | Avoids nested Neovim sessions from terminal Neovim. | Active only when a UI/server context is available. |

## LSP

| Integration | Config path | Description | Notes |
| --- | --- | --- | --- |
| Native `vim.lsp` | `lua/config/lsp.lua` | Configures Go, Python/Ruff, Rust, Ruby/Solargraph, Lua, and Puppet language servers. | Uses only binaries already available on `PATH`; see [LSP](lsp.md). |
| `stevearc/conform.nvim` | LazyVim core | Formatting integration. | Available from LazyVim, but external formatters must be installed outside Mason. |
| `mfussenegger/nvim-lint` | LazyVim core | Linting integration. | Available from LazyVim, but external linters must be installed outside Mason. |
| `nvim-treesitter/nvim-treesitter` | `lua/plugins/treesitter.lua` | Syntax parser management. | LazyVim baseline with local parser coverage for shell, YAML, and LSP-backed languages; parser builds may require the external `tree-sitter` CLI. |
| `nvim-treesitter/nvim-treesitter-textobjects` | LazyVim core | Treesitter textobjects. | Pulled by LazyVim's Treesitter baseline. |
| `windwp/nvim-ts-autotag` | LazyVim core | Treesitter-powered tag updates. | Pulled by LazyVim for supported filetypes. |
| `JoosepAlviste/nvim-ts-context-commentstring` | LazyVim core | Context-aware comment strings. | Supports comment behavior in embedded languages. |
| `folke/ts-comments.nvim` | LazyVim core | Treesitter-aware comment helpers. | Part of LazyVim's comment baseline. |

## Colorschemes

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/tokyonight.nvim` | `lua/plugins/colorschemes.lua` | Tokyo Night colorscheme. | Default profile selected by `lua/config/theme.lua`. |
| `arcticicestudio/nord-vim` | `lua/plugins/colorschemes.lua` | Nord colorscheme. | Selected by the migrated `pUSER` theme profile and available as `:colorscheme nord`. |
| `catppuccin/nvim` | `lua/plugins/colorschemes.lua` | Catppuccin colorscheme collection. | Available for future profiles as `catppuccin` plus latte/frappe/macchiato/mocha variants. |
| `rebelot/kanagawa.nvim` | `lua/plugins/colorschemes.lua` | Kanagawa colorscheme collection. | Available for future profiles as `kanagawa`, `kanagawa-wave`, `kanagawa-dragon`, and `kanagawa-lotus`. |

## Deferred

| Plugin | Reason |
| --- | --- |
| AI assistant plugin | No Neovim-native AI plugin is active. Crush is integrated through Snacks terminal mappings; CodeCompanion and Parrot remain future candidates. See [AI-assisted coding](ai.md). |
