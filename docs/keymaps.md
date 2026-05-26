# Keymaps

LazyVim provides the base keymap set. This page documents local keymaps added
or intentionally preserved from the previous config. The leader key is comma
(`,`).
Actual mappings live near their plugin or runtime owner. `which-key` owns local
discoverability metadata and group labels in `lua/plugins/which-key.lua`.

## Search And Pickers

Bare `<leader>f` and `<leader>s` are intentionally kept as immediate
old-config style picker actions, now backed by Snacks picker. LazyVim's broader
picker families are moved under `<leader>p` so they do not make Neovim wait for
a longer key sequence.
The same rule applies to `<leader>b`: buffer-management commands live under
`<leader>B`, leaving `<leader>b` as the immediate buffer picker.

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>f` | Find project files. | `lua/plugins/pickers.lua` |
| Normal | `<leader>F` | Prompt for a directory and find files inside it. | `lua/plugins/pickers.lua` |
| Normal | `<leader>l` | Resume the last picker. | `lua/plugins/pickers.lua` |
| Normal | `<leader>b` | List open buffers. | `lua/plugins/pickers.lua` |
| Normal | `<leader>s` | Live grep. | `lua/plugins/pickers.lua` |
| Normal | `<leader>S` | Prompt for a directory and live grep inside it. | `lua/plugins/pickers.lua` |
| Normal | `<leader>th` | Search help tags. | `lua/plugins/pickers.lua` |
| Normal | `<leader>tc` | Preview and select colorschemes. | `lua/plugins/pickers.lua` |
| Normal | `<leader>ts` | Search document symbols filtered to major code symbols. | `lua/plugins/pickers.lua` |

## Picker Namespace

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>pff` | Find files from the project root with the LazyVim/Snacks picker. | `lua/plugins/pickers.lua` |
| Normal | `<leader>pfF` | Find files from the current working directory. | `lua/plugins/pickers.lua` |
| Normal | `<leader>pfb` | Pick buffers. | `lua/plugins/pickers.lua` |
| Normal | `<leader>pfg` | Pick git-tracked files. | `lua/plugins/pickers.lua` |
| Normal | `<leader>pfr` | Pick recent files. | `lua/plugins/pickers.lua` |
| Normal | `<leader>pfe` | Open Snacks explorer at the project root. | `lua/plugins/snacks-explorer.lua` |
| Normal | `<leader>psg` | Grep from the project root with the LazyVim/Snacks picker. | `lua/plugins/pickers.lua` |
| Normal | `<leader>psG` | Grep from the current working directory. | `lua/plugins/pickers.lua` |
| Normal/Visual | `<leader>psw` | Search the current word or visual selection from the project root. | `lua/plugins/pickers.lua` |
| Normal/Visual | `<leader>psr` | Search and replace with Grug Far. | `lua/plugins/pickers.lua` |
| Normal | `<leader>psh` | Pick help pages. | `lua/plugins/pickers.lua` |
| Normal | `<leader>psk` | Pick keymaps. | `lua/plugins/pickers.lua` |
| Normal | `<leader>psn…` | Noice message pickers and actions. | `lua/plugins/pickers.lua` |
| Normal | `<leader>pst` | Pick TODO comments. | `lua/plugins/pickers.lua` |
| Normal | `<leader>psT` | Pick TODO/FIX/FIXME comments. | `lua/plugins/pickers.lua` |

## Tools And Terminal

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>d` | Open the project directory tree. | `lua/plugins/snacks-explorer.lua` |
| Normal | `mf` | Reveal the current file in the explorer. | `lua/plugins/snacks-explorer.lua` |
| Normal/Terminal | `<leader>te` | Toggle a root terminal. | `lua/plugins/snacks-terminal.lua` |
| Normal | `<leader>tt` | Toggle a root terminal. | `lua/plugins/snacks-terminal.lua` |
| Normal | `<leader>tg` | Toggle a floating lazygit terminal. | `lua/plugins/snacks-terminal.lua` |
| Normal | `<leader>tpp` | Toggle Snacks profiler. | `lua/config/keymaps.lua` |
| Normal | `<leader>tph` | Toggle Snacks profiler highlights. | `lua/config/keymaps.lua` |
| Normal | `<leader>tps` | Open Snacks profiler scratch buffer. | `lua/config/keymaps.lua` |
| Normal | `<leader>u` | Open the Neovim 0.12 native undo tree. | `lua/config/keymaps.lua` |
| Terminal | `<Esc><Esc>` | Leave terminal mode. | `lua/config/misc.lua` |

## Editing

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>q` | Close current buffer while keeping the window layout. | `lua/config/keymaps.lua` |
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
| Normal | `<Tab>` | Focus the next buffer in the tabline. | `lua/config/keymaps.lua` |
| Normal | `<S-Tab>` | Focus the previous buffer in the tabline. | `lua/config/keymaps.lua` |
| Normal | `<leader>Bb` | Switch to the alternate buffer. | `lua/config/keymaps.lua` |
| Normal | `<leader>Bd` | Delete the current buffer. | `lua/config/keymaps.lua` |
| Normal | `<leader>Bo` | Delete other buffers. | `lua/config/keymaps.lua` |
| Normal | `<leader>Bi` | Delete invisible buffers. | `lua/config/keymaps.lua` |
| Normal | `<leader>BD` | Delete the buffer and window. | `lua/config/keymaps.lua` |
| Normal | `<leader>Bp` | Toggle buffer pin. | `lua/plugins/bufferline.lua` |
| Normal | `<leader>BP` | Delete non-pinned buffers. | `lua/plugins/bufferline.lua` |
| Normal | `<leader>Br` | Delete buffers to the right. | `lua/plugins/bufferline.lua` |
| Normal | `<leader>Bl` | Delete buffers to the left. | `lua/plugins/bufferline.lua` |
| Normal | `<leader>Bj` | Pick buffer from the tabline. | `lua/plugins/bufferline.lua` |

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
| `<leader>B` | Buffers |
| `<leader>c` | Code |
| `<leader>g` | Git |
| `<leader>p` | Pickers |
| `<leader>pf` | Find |
| `<leader>ps` | Search |
| `<leader>psn` | Noice |
| `<leader>t` | Tools |
| `<leader>tp` | Profiler |
| `m` | More |
| `gs` | Surround |

Other LazyVim groups remain provided by LazyVim itself.
