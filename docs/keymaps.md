# Keymaps

LazyVim provides the base keymap set. This page documents local keymaps added
or intentionally preserved from the previous config. The leader key is comma
(`,`). Runtime mappings use `<leader>` internally, but this page shows the keys
as typed.

Actual mappings live near their plugin or runtime owner. `which-key` owns local
discoverability metadata and group labels in `lua/plugins/which-key.lua`.

## Most Used Keys

| Key | Action |
| --- | --- |
| `,f` | Find project files. |
| `,s` | Live grep. |
| `,b` | Pick open buffers. |
| `,d` | Open the project directory tree. |
| `mf` | Reveal the current file in the explorer. |
| `,F` | Find files in a chosen directory. |
| `,S` | Grep in a chosen directory. |
| `,q` | Close the current buffer without disrupting the window layout. |
| `,te` / `,tt` | Toggle a project-root terminal. |
| `,tg` | Open lazygit in a floating terminal. |

## Search And Pickers

Bare `,f` and `,s` are intentionally kept as immediate old-config style picker
actions, now backed by Snacks picker. LazyVim's broader picker families are
moved under `,p` so they do not make Neovim wait for a longer key sequence.
The same rule applies to `,b`: buffer-management commands live under `,B`,
leaving `,b` as the immediate buffer picker.

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `,f` | Find project files. | `lua/plugins/pickers.lua` |
| Normal | `,F` | Prompt for a directory and find files inside it. | `lua/plugins/pickers.lua` |
| Normal | `,l` | Resume the last picker. | `lua/plugins/pickers.lua` |
| Normal | `,b` | List open buffers. | `lua/plugins/pickers.lua` |
| Normal | `,s` | Live grep. | `lua/plugins/pickers.lua` |
| Normal | `,S` | Prompt for a directory and live grep inside it. | `lua/plugins/pickers.lua` |
| Normal | `,th` | Search help tags. | `lua/plugins/pickers.lua` |
| Normal | `,tc` | Preview and select colorschemes. | `lua/plugins/pickers.lua` |
| Normal | `,ts` | Search document symbols filtered to major code symbols. | `lua/plugins/pickers.lua` |

## Picker Namespace

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `,pff` | Find files from the project root with the LazyVim/Snacks picker. | `lua/plugins/pickers.lua` |
| Normal | `,pfF` | Find files from the current working directory. | `lua/plugins/pickers.lua` |
| Normal | `,pfb` | Pick buffers. | `lua/plugins/pickers.lua` |
| Normal | `,pfg` | Pick git-tracked files. | `lua/plugins/pickers.lua` |
| Normal | `,pfr` | Pick recent files. | `lua/plugins/pickers.lua` |
| Normal | `,pfe` | Open Snacks explorer at the project root. | `lua/plugins/snacks-explorer.lua` |
| Normal | `,psg` | Grep from the project root with the LazyVim/Snacks picker. | `lua/plugins/pickers.lua` |
| Normal | `,psG` | Grep from the current working directory. | `lua/plugins/pickers.lua` |
| Normal/Visual | `,psw` | Search the current word or visual selection from the project root. | `lua/plugins/pickers.lua` |
| Normal/Visual | `,psr` | Search and replace with Grug Far. | `lua/plugins/pickers.lua` |
| Normal | `,psh` | Pick help pages. | `lua/plugins/pickers.lua` |
| Normal | `,psk` | Pick keymaps. | `lua/plugins/pickers.lua` |
| Normal | `,psn...` | Noice message pickers and actions. | `lua/plugins/pickers.lua` |
| Normal | `,pst` | Pick TODO comments. | `lua/plugins/pickers.lua` |
| Normal | `,psT` | Pick TODO/FIX/FIXME comments. | `lua/plugins/pickers.lua` |

## Tools And Terminal

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `,d` | Open the project directory tree. | `lua/plugins/snacks-explorer.lua` |
| Normal | `mf` | Reveal the current file in the explorer. | `lua/plugins/snacks-explorer.lua` |
| Normal/Terminal | `,te` | Toggle a root terminal. | `lua/plugins/snacks-terminal.lua` |
| Normal | `,tt` | Toggle a root terminal. | `lua/plugins/snacks-terminal.lua` |
| Normal | `,tg` | Toggle a floating lazygit terminal. | `lua/plugins/snacks-terminal.lua` |
| Normal | `,tpp` | Toggle Snacks profiler. | `lua/config/keymaps.lua` |
| Normal | `,tph` | Toggle Snacks profiler highlights. | `lua/config/keymaps.lua` |
| Normal | `,tps` | Open Snacks profiler scratch buffer. | `lua/config/keymaps.lua` |
| Normal | `,u` | Open the Neovim 0.12 native undo tree. | `lua/config/keymaps.lua` |
| Terminal | `<Esc><Esc>` | Leave terminal mode. | `lua/config/misc.lua` |

## Editing

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `,q` | Close current buffer while keeping the window layout. | `lua/config/keymaps.lua` |
| Normal/Visual | `ga` | Align text with Mini Align. | `lua/plugins/mini.lua` |
| Normal/Visual | `gA` | Align text with preview. | `lua/plugins/mini.lua` |
| Normal | `gS` | Toggle split/join form. | `lua/plugins/mini.lua` |
| Normal | `,cw` | Trim trailing whitespace. | `lua/plugins/mini.lua` |
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
| Normal | `<BS>` | Focus the window to the left; fallback for terminals that send `Ctrl-h` as Backspace. | `lua/config/keymaps.lua` |
| Normal | `,Bb` | Switch to the alternate buffer. | `lua/config/keymaps.lua` |
| Normal | `,Bd` | Delete the current buffer. | `lua/config/keymaps.lua` |
| Normal | `,Bo` | Delete other buffers. | `lua/config/keymaps.lua` |
| Normal | `,Bi` | Delete invisible buffers. | `lua/config/keymaps.lua` |
| Normal | `,BD` | Delete the buffer and window. | `lua/config/keymaps.lua` |
| Normal | `,Bp` | Toggle buffer pin. | `lua/plugins/bufferline.lua` |
| Normal | `,BP` | Delete non-pinned buffers. | `lua/plugins/bufferline.lua` |
| Normal | `,Br` | Delete buffers to the right. | `lua/plugins/bufferline.lua` |
| Normal | `,Bl` | Delete buffers to the left. | `lua/plugins/bufferline.lua` |
| Normal | `,Bj` | Pick buffer from the tabline. | `lua/plugins/bufferline.lua` |

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
| Normal/Visual | `,ca` | Code action. | `lua/config/lsp.lua` |
| Normal | `,cr` | Rename symbol. | `lua/config/lsp.lua` |
| Normal | `,cl` | Run `:checkhealth vim.lsp`. | `lua/config/lsp.lua` |

## Which-Key Groups

| Prefix | Group |
| --- | --- |
| `,` | Local |
| `,B` | Buffers |
| `,c` | Code |
| `,g` | Git |
| `,p` | Pickers |
| `,pf` | Find |
| `,ps` | Search |
| `,psn` | Noice |
| `,t` | Tools |
| `,tp` | Profiler |
| `m` | More |
| `gs` | Surround |

Other LazyVim groups remain provided by LazyVim itself.
