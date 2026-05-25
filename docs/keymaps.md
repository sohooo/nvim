# Keymaps

LazyVim provides the base keymap set. This page documents local keymaps added
or intentionally preserved from the previous config. The leader key is comma
(`,`).
Actual mappings live near their plugin or runtime owner. `which-key` owns local
discoverability metadata and group labels in `lua/plugins/which-key.lua`.

## Search And Telescope

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>f` | Find project files with `git_files`, falling back to `find_files`. | `lua/plugins/telescope.lua` |
| Normal | `<leader>l` | Resume the last Telescope picker. | `lua/plugins/telescope.lua` |
| Normal | `<leader>b` | List open buffers. | `lua/plugins/telescope.lua` |
| Normal | `<leader>s` | Live grep. | `lua/plugins/telescope.lua` |
| Normal | `<leader>th` | Search help tags. | `lua/plugins/telescope.lua` |
| Normal | `<leader>tc` | Preview and select colorschemes. | `lua/plugins/telescope.lua` |
| Normal | `<leader>ts` | Search document symbols filtered to major code symbols. | `lua/plugins/telescope.lua` |
| Telescope insert | `<Esc>` | Close the active picker. | `lua/plugins/telescope.lua` |
| Telescope buffer picker | `<C-d>` | Delete selected buffer. | `lua/plugins/telescope.lua` |

## Tools And Terminal

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `mf` | Reveal the current file in nvim-tree. | `lua/plugins/nvim-tree.lua` |
| Normal/Terminal | `<leader>te` | Toggle horizontal terminal. | `lua/plugins/toggleterm.lua` |
| Normal | `<leader>tt` | Re-run the last terminal command. | `lua/plugins/toggleterm.lua` |
| Normal | `<leader>tg` | Toggle a floating lazygit terminal. | `lua/plugins/toggleterm.lua` |
| Normal | `<leader>u` | Open the Neovim 0.12 native undo tree. | `lua/config/keymaps.lua` |
| Terminal | `<Esc><Esc>` | Leave terminal mode. | `lua/config/misc.lua` |

## Editing

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>q` | Close current buffer while keeping the window layout. | `lua/plugins/mini.lua` |
| Normal/Visual | `ga` | Align text with Mini Align. | `lua/plugins/mini.lua` |
| Normal/Visual | `gA` | Align text with preview. | `lua/plugins/mini.lua` |
| Normal | `gS` | Toggle split/join form. | `lua/plugins/mini.lua` |
| Normal | `<leader>cw` | Trim trailing whitespace. | `lua/plugins/mini.lua` |
| Normal/Visual | `gsa` | Add surrounding. | LazyVim Mini Surround extra |
| Normal | `gsd` | Delete surrounding. | LazyVim Mini Surround extra |
| Normal | `gsr` | Replace surrounding. | LazyVim Mini Surround extra |
| Normal | `gsh` | Highlight surrounding. | LazyVim Mini Surround extra |
| Normal | `gsf` | Find surrounding to the right. | LazyVim Mini Surround extra |
| Normal | `gsF` | Find surrounding to the left. | LazyVim Mini Surround extra |
| Normal | `gsn` | Update Mini Surround search line count. | LazyVim Mini Surround extra |
| Normal/Visual | `gc`/`gcc` family | Toggle comments. | LazyVim Mini Comment extra |
| Normal | `f`, `F`, `t`, `T` | Enhanced character jumps through Mini Jump. | `lua/plugins/mini.lua` |
| Insert | `<Tab>`/`<S-Tab>` | Tab out/back through delimiters. | `lua/plugins/tabout.lua` |

## LSP

These mappings are buffer-local and appear after a language server attaches.

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `gd` | Go to definition. | `lua/config/lsp.lua` |
| Normal | `gr` | References. | `lua/config/lsp.lua` |
| Normal | `gI` | Go to implementation. | `lua/config/lsp.lua` |
| Normal | `gy` | Go to type definition. | `lua/config/lsp.lua` |
| Normal | `gD` | Go to declaration. | `lua/config/lsp.lua` |
| Normal | `K` | Hover. | `lua/config/lsp.lua` |
| Normal | `gK` | Signature help. | `lua/config/lsp.lua` |
| Insert | `<C-k>` | Signature help. | `lua/config/lsp.lua` |
| Normal/Visual | `<leader>ca` | Code action. | `lua/config/lsp.lua` |
| Normal | `<leader>cr` | Rename symbol. | `lua/config/lsp.lua` |
| Normal | `<leader>cl` | Run `:checkhealth vim.lsp`. | `lua/config/lsp.lua` |

## Which-Key Groups

| Prefix | Group |
| --- | --- |
| `<leader>` | Local |
| `<leader>c` | Code |
| `<leader>g` | Git |
| `<leader>t` | Tools |
| `m` | More |
| `gs` | Surround |

Other LazyVim groups remain provided by LazyVim itself.
