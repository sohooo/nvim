# Keymaps

Custom mappings are defined mostly in [`../lua/sohooo/which-key.lua`](../lua/sohooo/which-key.lua),
with additional plugin-local mappings in [`../init.lua`](../init.lua),
[`../lua/sohooo/lsp.lua`](../lua/sohooo/lsp.lua),
[`../lua/sohooo/misc.lua`](../lua/sohooo/misc.lua), and
[`../lua/sohooo/nvim-tree.lua`](../lua/sohooo/nvim-tree.lua).

The global leader and local leader are both `,`.

## General Editing And Movement

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Insert | `kj` | Exit to normal mode. | `which-key.lua` |
| Visual | `J` | Move selected text down. | `which-key.lua` |
| Visual | `K` | Move selected text up. | `which-key.lua` |
| Visual | `>` | Indent selection and keep it selected. | `which-key.lua` |
| Visual | `<` | Dedent selection and keep it selected. | `which-key.lua` |
| Normal | `Q` | Disabled. | `which-key.lua` |
| Normal | `j` | Move by display line (`gj`). | `which-key.lua` |
| Normal | `k` | Move by display line (`gk`). | `which-key.lua` |
| Normal | `J` | Join lines while preserving cursor view. | `which-key.lua` |
| Normal | `n` | Next search match and center it. | `which-key.lua` |
| Normal | `N` | Previous search match and center it. | `which-key.lua` |
| Normal | `g;` | Older changelist entry and center it. | `which-key.lua` |
| Normal | `g,` | Newer changelist entry and center it. | `which-key.lua` |
| Normal | `cn` | Change current word, then repeat next match with `.`. | `which-key.lua` |
| Normal | `cN` | Change current word, then repeat previous match with `.`. | `which-key.lua` |
| Normal | `<space>l` | Clear search highlighting. | `which-key.lua` |
| Terminal | `<Esc><Esc>` | Leave terminal mode. | `misc.lua` |
| Normal | `s`, `S`, related Leap defaults | Leap jump motions. | `init.lua` |
| Normal/Visual | Comment.nvim defaults such as `gcc` | Toggle comments. | `Comment.nvim` setup in `init.lua` |
| Normal/Visual | nvim-surround defaults such as `ys`, `ds`, `cs` | Add/delete/change surroundings. | `nvim-surround` setup in `init.lua` |
| Normal/Visual | mini.align defaults such as `ga`, `gA` | Align text interactively. | `mini.align` setup in `init.lua` |

## Windows, Buffers, And Files

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<Tab>` | Next buffer. | `which-key.lua` |
| Normal | `<S-Tab>` | Previous buffer. | `which-key.lua` |
| Normal | `<C-h>` | Move to left window. | `which-key.lua` |
| Normal | `<C-j>` | Move to lower window. | `which-key.lua` |
| Normal | `<C-k>` | Move to upper window. | `which-key.lua` |
| Normal | `<C-l>` | Move to right window. | `which-key.lua` |
| Normal | `<leader>d` | Toggle NvimTree. | `which-key.lua` |
| Normal | `<leader>q` | Delete current buffer while keeping the window layout. | `which-key.lua` |
| Normal | `<leader>mf` | Reveal current file in NvimTree. | `which-key.lua` |
| Normal | `<leader>mm` | Toggle mouse support. | `which-key.lua` |

## Telescope

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `<leader>f` | Find files. | `which-key.lua` |
| Normal | `<leader>l` | Resume last Telescope picker. | `which-key.lua` |
| Normal | `<leader>b` | List open buffers. | `which-key.lua` |
| Normal | `<leader>s` | Live grep. | `which-key.lua` |
| Normal | `<leader>th` | Help tags. | `which-key.lua` |
| Normal | `<leader>tc` | Colorschemes with preview. | `which-key.lua` |
| Normal | `<leader>td` | TODO comments picker. | `which-key.lua` |
| Normal | `<leader>ts` | Document symbols filtered to major code symbols. | `which-key.lua` |
| Normal | `<leader>ha` | Autocommands picker. | `which-key.lua` |
| Normal | `<leader>hc` | Commands picker. | `which-key.lua` |
| Normal | `<leader>hf` | Filetypes picker. | `which-key.lua` |
| Normal | `<leader>hh` | Help tags picker. | `which-key.lua` |
| Normal | `<leader>hk` | Keymaps picker. | `which-key.lua` |
| Normal | `<leader>hm` | Man pages picker. | `which-key.lua` |
| Normal | `<leader>ho` | Vim options picker. | `which-key.lua` |
| Normal | `<leader>hs` | Highlights picker. | `which-key.lua` |
| Normal | `<leader>ht` | Telescope builtins picker. | `which-key.lua` |
| Telescope insert | `<Esc>` | Close picker. | `telescope.lua` |
| Telescope insert/normal in buffers picker | `<C-d>` | Delete selected buffer. | `telescope.lua` |

## LSP, Diagnostics, And Code Actions

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `K` | Show LSP hover. | `which-key.lua` |
| Normal | `gh` | Show LSP hover. | `which-key.lua` |
| Normal | `<C-p>` | Previous diagnostic. | `which-key.lua` |
| Normal | `<C-n>` | Next diagnostic. | `which-key.lua` |
| Normal | `gd` | Preview definition. | `which-key.lua` |
| Normal | `gD` | Go to definition. | `which-key.lua` |
| Normal | `gi` | Preview implementation. | `which-key.lua` |
| Normal | `gI` | Go to implementation. | `which-key.lua` |
| Normal | `gr` | Preview references. | `which-key.lua` |
| Normal | `gR` | Go to references. | `which-key.lua` |
| Normal | `gpp` | Close all goto-preview windows. | `which-key.lua` |
| Normal | `gpd` | Preview definition. | `which-key.lua` |
| Normal | `gpi` | Preview implementation. | `which-key.lua` |
| Normal | `gpr` | Preview references. | `which-key.lua` |
| Normal | `<leader>ca` | Code action. | `which-key.lua` |
| Normal | `<leader>cr` | Rename symbol. | `which-key.lua` |
| Normal | `<leader>cf` | Format buffer via LSP. | `which-key.lua` |
| Normal | `<leader>cs` | Toggle symbols outline. | `init.lua` |
| Normal/Visual | `<leader>cR` | Structural search and replace. | `init.lua` |
| Visual | `<leader>cv` | Refactor selected code. | `which-key.lua` |
| Normal | `<leader>wa` | Add workspace folder. | `which-key.lua` |
| Normal | `<leader>wl` | List workspace folders. | `which-key.lua` |
| Normal | `<leader>wr` | Remove workspace folder. | `which-key.lua` |

## Completion And Snippets

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Insert | `<Up>` | Previous completion item. | `lsp.lua` |
| Insert | `<Down>` | Next completion item. | `lsp.lua` |
| Insert | `<C-p>` | Previous completion item. | `lsp.lua` |
| Insert | `<C-n>` | Next completion item. | `lsp.lua` |
| Insert | `<C-j>` | Scroll completion docs down. | `lsp.lua` |
| Insert | `<C-k>` | Scroll completion docs up. | `lsp.lua` |
| Insert | `<Tab>` | Confirm explicitly selected completion item. | `lsp.lua` |
| Insert | `<CR>` | Confirm explicitly selected completion item. | `lsp.lua` |
| Insert/Snippet | `<C-f>` | Jump to next snippet placeholder. | `lsp.lua` |
| Insert/Snippet | `<C-b>` | Jump to previous snippet placeholder. | `lsp.lua` |

## Terminals, Git, Diff, And Tests

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal/Terminal | `<leader>te` | Toggle horizontal ToggleTerm terminal. | `which-key.lua` |
| Normal | `<leader>tt` | Rerun last terminal command with `TermExec cmd='!!'`. | `which-key.lua` |
| Normal | `<leader>g` | Toggle floating lazygit terminal. | `which-key.lua` |
| Normal | `<leader>u` | Toggle undotree. | `which-key.lua` |
| Normal | `<leader>vv` | Open Diffview. | `which-key.lua` |
| Normal | `<leader>vo` | Open Diffview. | `which-key.lua` |
| Normal | `<leader>vc` | Close Diffview. | `which-key.lua` |
| Normal | `<leader>vh` | Open repository file history. | `which-key.lua` |
| Normal | `<leader>vf` | Open current file history. | `which-key.lua` |
| Normal | `<leader>rn` | Run nearest test. | `which-key.lua` |
| Normal | `<leader>rr` | Run nearest test. | `which-key.lua` |
| Normal | `<leader>rf` | Run current test file. | `which-key.lua` |
| Normal | `<leader>ra` | Run all tests from current working directory. | `which-key.lua` |
| Normal | `<leader>ro` | Open neotest output window. | `which-key.lua` |
| Normal | `<leader>rp` | Toggle neotest output panel. | `which-key.lua` |
| Normal | `<leader>rs` | Toggle neotest summary panel. | `which-key.lua` |
| Normal | `<leader>rw` | Toggle watch for current test file. | `which-key.lua` |

## Plugin-Local File Explorer Mappings

These mappings apply inside `nvim-tree` buffers in addition to the plugin defaults.

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| Normal | `s` | Open node in vertical split. | `nvim-tree.lua` |
| Normal | `i` | Open node in horizontal split. | `nvim-tree.lua` |
| Normal | `t` | Open node in new tab. | `nvim-tree.lua` |
| Normal | `?` | Toggle nvim-tree help. | `nvim-tree.lua` |

## Which-Key Groups

| Prefix | Group |
| --- | --- |
| `<leader>` | Main mappings |
| `<leader>c` | Code actions and editing actions |
| `<leader>ct` | Treesitter actions |
| `<leader>h` | Help and introspection pickers |
| `<leader>m` | Miscellaneous helpers |
| `<leader>r` | Test runner actions |
| `<leader>t` | Telescope and terminal actions |
| `<leader>v` | Diffview actions |
| `<leader>w` | LSP workspace actions |
| `g` | LSP/goto actions |
| `gp` | Goto-preview actions |

