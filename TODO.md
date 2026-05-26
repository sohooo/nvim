# Plugin Migrations

Migrate the following plugins one by one by adding them to the correct position in `lua/plugins/`. Take inspiration from the old configuration under `prev_cfg/` regarding bindings (which-key) and settings for the current version of the plugin (where it makes sense).

After successful and verified integration of the plugin, move it from the `## todo` to the `## done` section below.
When the todo list is empty, promote the next deferred or omitted item by following `docs/migration-workflow.md`.


## done

- which-key
- quickfix-reflector.vim
- nvim-unception
- vim-fugitive
- vim-dispatch
- nord-vim
- catppuccin
- kanagawa
- mini.nvim
  - mini.surround (replaces nvim-surround)
  - mini.comment (replaces Comment.nvim)
  - mini.pairs (replaces nvim-autopairs)
  - mini.splitjoin
  - mini.align
  - mini.jump (replaces vim-sneak)
  - mini.trailspace
  - mini.icons
  - mini.snippets
- neovim 0.12-native undotree
- migrated-plugin smoke checks
- external-tool prerequisite check
- healthcheck capture script
- healthcheck findings baseline
- migration status check
- migration decisions baseline
- combined verification target
- migration workflow documentation
- empty migration queue handoff
- native LSP setup
- Snacks explorer
- Snacks picker
- Snacks terminal
- LazyVim lualine/bufferline/gitsigns defaults
- LazyVim todo-comments baseline
- nvim-treesitter-context

## removed

| Removed item | Replacement | Reason |
| --- | --- | --- |
| `telescope.nvim` | Snacks picker | Prefer LazyVim's built-in picker stack while preserving `,f`, `,b`, and `,s`. |
| `telescope-fzf-native.nvim` | Snacks picker | Telescope-specific sorter is no longer needed. |
| `toggleterm.nvim` | Snacks terminal | Prefer LazyVim's built-in terminal helper while preserving `,te`, `,tt`, and `,tg`. |
| `focus.nvim` | LazyVim window tools | Removed adjacent auto-resize behavior to reduce local layout policy. |
| `tabout.nvim` | Mini pairs and default insert-mode behavior | Removed insert-mode `<Tab>` overlap. |
| `vim-pasta` | Neovim/LazyVim paste behavior | Removed legacy paste override until a concrete paste issue returns. |
| `vim-repeat` | Native/LazyVim plugin behavior | Removed low-signal compatibility plugin with no current mapped workflow. |
| `mini.bufremove` | `Snacks.bufdelete()` | Avoid duplicate buffer deletion implementation. |
| `mini.statusline` | `lualine.nvim` | Restore LazyVim's default statusline. |
| `mini.tabline` | `bufferline.nvim` | Restore LazyVim's default bufferline. |
| `mini.diff` | `gitsigns.nvim` | Restore LazyVim's default Git signs integration. |
| `mini.cursorword` | `Snacks.words` | Prefer LazyVim's built-in word reference behavior. |
| `mini.cmdline` | Noice/LazyVim UI | Avoid overlapping command-line UI layers. |
| `mini.indentscope` | Snacks/LazyVim indent behavior | Avoid duplicate scope/indent visuals. |

## todo

No active migration items.

## deferred

- https://github.com/folke/sidekick.nvim#-ai-cli-integration - AI CLI integration
  - Requires a configured Copilot LSP and optional AI CLI binaries provided outside Mason.
  - External binary policy is documented in `docs/external-tools.md`.
  - Revisit after Copilot LSP and desired AI CLI commands are configured explicitly.

## review

| Item | Old source | Current decision | Suggested next action | Prerequisites |
| --- | --- | --- | --- | --- |
| `MyColors()` user/theme switch | `prev_cfg/init.lua` | Not migrated. | Revisit if `GIT_USERNAME`-based theme selection is still useful. | Theme policy. |
| Global `Hifi()` helper | `prev_cfg/init.lua` | Replaced by plugin-local `NVIM_STYLE` checks. | Keep local helpers unless many plugins need the same function. | None. |
| Lo-fi `termguicolors = false` branch | `prev_cfg/init.lua` | Not migrated; truecolor remains LazyVim baseline. | Revisit if plain terminal color support is needed. | Plain terminal target. |
| Mouse toggle helper | `prev_cfg/lua/sohooo/which-key.lua` | Not migrated; mouse is disabled by option. | Add a toggle mapping only if runtime mouse switching is wanted. | Keymap preference. |
| Old bootstrap/runtime shims | `prev_cfg/init.lua` | Not migrated. | No action; LazyVim and project-local XDG startup replace them. | None. |
| `stevearc/dressing.nvim` | `prev_cfg/init.lua` | Omitted; LazyVim/Snacks provides UI integration. | Revisit only if Snacks input/select remains insufficient. | Concrete UI issue. |
| `sindrets/diffview.nvim` | `prev_cfg/init.lua` | Omitted; Gitsigns and Fugitive cover the current Git baseline. | Revisit if file history/diff review UI is wanted. | Git workflow preference. |
| `levouh/tint.nvim` | `prev_cfg/init.lua` | Omitted; LazyVim/Snacks window tools cover the current focus baseline. | Revisit if inactive-window dimming is still wanted. | None. |
| `nacro90/numb.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit if line-number preview workflow is missed. | None. |
| `HampusHauffman/block.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit if code block highlighting is wanted. | None. |
| `rmagatti/goto-preview` | `prev_cfg/init.lua` | Omitted; LazyVim LSP navigation is baseline. | Revisit if preview windows are preferred over jumps. | LSP keymap policy. |
| `norcalli/nvim-colorizer.lua` | `prev_cfg/init.lua` | Omitted. | Consider a current colorizer plugin if color previews are wanted. | None. |
| `xorid/asciitree.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit if `:AsciiTree` is still used. | None. |
| `smjonas/live-command.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit if live command preview is useful. | None. |
| `onsails/lspkind-nvim` | `prev_cfg/init.lua` | Omitted; LazyVim completion UI is baseline. | Revisit only if completion labels/icons are insufficient. | Completion engine decision. |
| `j-hui/fidget.nvim` | `prev_cfg/init.lua` | Omitted; LazyVim/Snacks/Noice handles UI notifications/progress. | Revisit if LSP progress UI needs a dedicated plugin. | LSP workflow preference. |
| `nvim-cmp` and `cmp-*` sources | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/lsp.lua` | Replaced by LazyVim completion baseline, currently `blink.cmp`. | Revisit only if `nvim-cmp` behavior is specifically preferred. | Completion engine decision. |
| `LuaSnip`, `cmp_luasnip` | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/lsp.lua` | Replaced by `mini.snippets`. | Revisit only if LuaSnip-specific snippets/features are needed. | Snippet engine decision. |
| `friendly-snippets` | `prev_cfg/init.lua` | Covered by LazyVim baseline. | Keep as dependency unless snippet engine changes. | None. |
| `nvim-tree/nvim-tree.lua` | `prev_cfg/init.lua` | Replaced by Snacks explorer. | No action unless Snacks explorer lacks a required workflow. | Concrete explorer gap. |
| `none-ls.nvim`, `none-ls-extras.nvim` | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/null-ls.lua` | Deferred; external formatter/linter policy is no Mason auto-install. | Select external tools first, then migrate sources intentionally. | Tools available on `PATH`. |
| `neotest`, `neotest-rspec` | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/neotest.lua` | Omitted. | Define test runner workflow before adding back. | Ruby/RSpec tooling on `PATH`. |
| `ThePrimeagen/refactoring.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit with concrete refactoring mappings. | Treesitter parser coverage. |
| `simrat39/symbols-outline.nvim` | `prev_cfg/init.lua` | Omitted; LazyVim symbol navigation is baseline. | Revisit if a persistent outline panel is wanted. | None. |
| `cshuaimin/ssr.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit if structural search/replace is still wanted. | Treesitter parser coverage. |
| Optional Python type server: `pyright` or `pylsp` | `prev_cfg/lua/sohooo/lsp.lua` | Deferred; Python currently uses Ruff only. | Add only if Python type/completion support is needed beyond Ruff. | External `pyright` or `pylsp` on `PATH`. |
| Language-specific plugins: `vim-go`, `rust-tools.nvim`, `dbtpal` | `prev_cfg/init.lua` | Deferred; baseline LSP uses native `vim.lsp`. | Migrate one workflow at a time only if native LSP is insufficient. | External language tools supplied outside Mason. |
| Formatting/linting beyond LSP | `prev_cfg/lua/sohooo/null-ls.lua` | Deferred. | Decide between native LSP formatting, conform/lint integrations, or no extra layer. | External formatters/linters on `PATH`. |
| `nvim-dap` | `prev_cfg/init.lua` | Deferred. | Add only with selected adapters. | Debug adapters supplied outside Mason. |
| `vim-go` globals from `misc.lua` | `prev_cfg/lua/sohooo/misc.lua` | Blocked. | Copy only if `vim-go` is reintroduced. | `vim-go` migrated. |
| Commented treesitter extras | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/treesitter.lua` | Not migrated; inactive in old baseline. | Promote individually only if a concrete treesitter workflow is wanted. | Parser/tooling coverage. |
| Commented Noice setup | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/noice.lua` | Not migrated from old config; LazyVim already includes its own UI choices. | Revisit only through LazyVim extras/UI policy. | UI preference. |
| Additional old colorschemes | `prev_cfg/init.lua` | Omitted. | Add only themes that are actively used. | Theme preference. |

## LazyVim overlap review

The direct overlap items from the first review were resolved by the removal
table above. Remaining items are intentionally distinct workflows to revisit
only if they become noisy or unused.

| Area | Current local piece | LazyVim/baseline overlap | Current impact | Suggested next action |
| --- | --- | --- | --- | --- |
| File explorer keys | `lua/plugins/snacks-explorer.lua` customizes Snacks explorer. | LazyVim already provides Snacks explorer as the default explorer extra. | Intentional key and behavior override, not a plugin duplicate. | Keep unless LazyVim upstream key behavior becomes preferable. |
| Completion/snippets | `mini.snippets` LazyVim extra with Blink completion. | LazyVim Blink baseline can work with multiple snippet engines depending on extras. | Intentional current snippet choice. | Keep unless snippet behavior requires LuaSnip or native snippets. |
| Quickfix editing | `quickfix-reflector.vim`. | LazyVim/Trouble/Snacks provide quickfix viewing and pickers, but not write-back editing. | Distinct capability with adjacent UI overlap. | Keep if editing quickfix lists is part of the workflow. |
| Git workflow | `vim-fugitive`, lazygit terminal, Snacks Git pickers, and Gitsigns. | LazyVim/Snacks already provide git pickers and terminal helpers. | Multiple Git interfaces with overlapping but distinct workflows. | Keep Fugitive while `:Git` command workflows are useful. |
