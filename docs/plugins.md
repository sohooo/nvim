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
| `neovim/nvim-lspconfig` | `lua/plugins/mason.lua` | Legacy LSP server config collection. | Explicitly disabled. Native `vim.lsp` setup lives in `lua/config/lsp.lua`. |
| `mason-org/mason.nvim` | `lua/plugins/mason.lua` | External tool installer. | Explicitly disabled. Tools must be installed outside this config. |
| `mason-org/mason-lspconfig.nvim` | `lua/plugins/mason.lua` | Mason/LSP bridge. | Explicitly disabled. |
| `jay-babu/mason-nvim-dap.nvim` | `lua/plugins/mason.lua` | Mason/DAP bridge. | Explicitly disabled. |

## Search And Navigation

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `nvim-telescope/telescope.nvim` | `lua/plugins/telescope.lua` | Fuzzy finder for project files, buffers, grep, help, colorschemes, and document symbols. | Keeps the previous config's main Telescope bindings. |
| `nvim-telescope/telescope-fzf-native.nvim` | `lua/plugins/telescope.lua` | Native FZF sorter for Telescope. | Built with `make` when available. |
| `nvim-lua/plenary.nvim` | `lua/plugins/telescope.lua` | Lua utility dependency. | Telescope dependency. |
| `nvim-mini/mini.jump` | `lua/plugins/mini.lua` | Enhanced `f`, `F`, `t`, and `T` motions. | Migrated as the Mini replacement for sneak-style movement. |

## UI And Layout

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/which-key.nvim` | `lua/plugins/which-key.lua` | Shows available key sequences while typing. | Adds the local `<leader>t` tools group. |
| `beauwilliams/focus.nvim` | `lua/plugins/focus.lua` | Auto-resizes focused windows. | Disabled for prompt, nofile, popup, and tree-like buffers. |
| `nvim-mini/mini.statusline` | `lua/plugins/mini.lua` | Statusline. | Replaces `lualine.nvim`; icons follow `NVIM_STYLE`. |
| `nvim-mini/mini.tabline` | `lua/plugins/mini.lua` | Buffer/tab line. | Replaces `bufferline.nvim`/old tabline usage; icons follow `NVIM_STYLE`. |
| `nvim-mini/mini.indentscope` | `lua/plugins/mini.lua` | Active indentation scope indicator. | Imported from LazyVim's Mini extra and replaces indent-blankline scope behavior. |
| `nvim-mini/mini.icons` | LazyVim core | Icon provider. | Already enabled by LazyVim; used instead of adding a separate icon layer. |

## Editing

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `nvim-mini/mini.surround` | `lua/plugins/mini.lua` | Add, delete, and replace surrounding delimiters. | Imported from LazyVim's Mini extra; replaces `nvim-surround`. |
| `nvim-mini/mini.comment` | `lua/plugins/mini.lua` | Comment toggling. | Imported from LazyVim's Mini extra; replaces `Comment.nvim`. |
| `nvim-mini/mini.pairs` | LazyVim core | Automatic bracket and quote pairing. | Replaces `nvim-autopairs`; already enabled by LazyVim. |
| `nvim-mini/mini.bufremove` | `lua/plugins/mini.lua` | Delete buffers while preserving window layout. | Replaces `bufdelete.nvim`; mapped to `<leader>q`. |
| `nvim-mini/mini.align` | `lua/plugins/mini.lua` | Interactive alignment. | Keeps `ga` and `gA` mappings. |
| `nvim-mini/mini.splitjoin` | `lua/plugins/mini.lua` | Toggle between single-line and multi-line forms. | Mapped to `gS`. |
| `nvim-mini/mini.cursorword` | `lua/plugins/mini.lua` | Highlight word under cursor. | Replaces `vim-illuminate`. |
| `nvim-mini/mini.trailspace` | `lua/plugins/mini.lua` | Highlight and trim trailing whitespace. | Trim mapped to `<leader>cw`. |
| `nvim-mini/mini.cmdline` | `lua/plugins/mini.lua` | Enhanced command-line editing UI. | Loads on command-line entry. |
| `nvim-mini/mini.snippets` | `lua/plugins/mini.lua` | Snippet engine. | Imported from LazyVim's Mini extra; replaces LuaSnip for this baseline. |
| `tpope/vim-repeat` | `lua/plugins/vim-repeat.lua` | Makes supported plugin actions repeatable with `.`. | Kept from the previous config. |
| `sickill/vim-pasta` | `lua/plugins/vim-pasta.lua` | Smarter indentation while pasting. | Kept from the previous config. |
| `stefandtw/quickfix-reflector.vim` | `lua/plugins/quickfix-reflector.lua` | Edit quickfix entries and write changes back to files. | Kept from the previous config. |
| `abecodes/tabout.nvim` | `lua/plugins/tabout.lua` | Tab out of quotes/brackets in insert mode. | Keeps the plugin's default `<Tab>`/`<S-Tab>` behavior. |
| Native `nvim.undotree` | `lua/config/keymaps.lua` | Neovim 0.12 built-in undo tree viewer. | Loaded on demand with `:packadd nvim.undotree`; mapped to `<leader>u`. |

## Git And Terminal

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `nvim-mini/mini.diff` | `lua/plugins/mini.lua` | Git diff signs and overlay. | Imported from LazyVim's Mini extra; replaces `gitsigns.nvim`. |
| `tpope/vim-fugitive` | `lua/plugins/fugitive.lua` | Git command integration inside Neovim. | Loaded on Fugitive commands such as `:Git`; complements lazygit and Mini diff. |
| `tpope/vim-dispatch` | `lua/plugins/dispatch.lua` | Async build and command dispatcher. | Loaded on Dispatch commands; no external tool is invoked at startup. |
| `akinsho/toggleterm.nvim` | `lua/plugins/toggleterm.lua` | Terminal management. | Provides horizontal terminal, rerun command, lazygit terminal, and vim-test strategy. |
| `samjwill/nvim-unception` | `lua/plugins/nvim-unception.lua` | Avoids nested Neovim sessions from terminal Neovim. | Active only when a UI/server context is available. |

## LSP

| Integration | Config path | Description | Notes |
| --- | --- | --- | --- |
| Native `vim.lsp` | `lua/config/lsp.lua` | Configures Go, Python/Ruff, Rust, Ruby LSP, Lua, and Puppet language servers. | Uses only binaries already available on `PATH`; see [LSP](lsp.md). |

## Colorschemes

| Plugin | Config path | Description | Notes |
| --- | --- | --- | --- |
| `folke/tokyonight.nvim` | LazyVim core | Tokyo Night colorscheme. | LazyVim default remains unchanged. |
| `arcticicestudio/nord-vim` | `lua/plugins/colorschemes.lua` | Nord colorscheme. | Migrated from the previous config and available as `:colorscheme nord`. |
| `catppuccin/nvim` | `lua/plugins/colorschemes.lua` | Catppuccin colorscheme collection. | Available as `catppuccin` plus latte/frappe/macchiato/mocha variants. |
| `rebelot/kanagawa.nvim` | `lua/plugins/colorschemes.lua` | Kanagawa colorscheme collection. | Available as `kanagawa`, `kanagawa-wave`, `kanagawa-dragon`, and `kanagawa-lotus`. |

## Deferred

| Plugin | Reason |
| --- | --- |
| `folke/sidekick.nvim` | Deferred until Copilot LSP and external AI CLI binaries are configured outside Mason. See [External tools](external-tools.md). |
