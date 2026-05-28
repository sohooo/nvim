# Plugin Migrations

Use this file only for the active migration queue and pending review items.
Historical migrated, replaced, removed, and omitted decisions live in
`docs/migration-decisions.md`.

When promoting work, follow `docs/migration-workflow.md`: migrate one workflow
at a time, keep plugin specs under `lua/plugins/`, document external binaries,
and run the configured verification checks.

## todo

No active migration items.

## deferred

- AI-assisted coding
  - Current decision: prefer a small Crush terminal integration next.
  - Next action: add optional `crush` tool docs/checks, then add Snacks terminal mappings and commands.
  - Prerequisites: `crush` installed on `PATH` and configured for the local endpoint.
  - Notes: CodeCompanion and Parrot remain future candidates; Node-required AI plugins are out of scope.
- Formatting/linting beyond LSP
  - Current decision: deferred; external formatter/linter policy is no Mason auto-install.
  - Next action: decide between native LSP formatting, conform/lint integrations, or no extra layer.
  - Prerequisites: external formatters/linters on `PATH`.
- Debugging
  - Current decision: deferred.
  - Next action: add only with selected adapters.
  - Prerequisites: debug adapters supplied outside Mason.
- Test runner integration
  - Current decision: deferred.
  - Next action: define test runner workflow before adding plugins back.
  - Prerequisites: language-specific test tools on `PATH`.

## review

| Item | Old source | Current decision | Suggested next action | Prerequisites |
| --- | --- | --- | --- | --- |
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
| `neotest`, `neotest-rspec` | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/neotest.lua` | Omitted. | Define test runner workflow before adding back. | Ruby/RSpec tooling on `PATH`. |
| `ThePrimeagen/refactoring.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit with concrete refactoring mappings. | Treesitter parser coverage. |
| `simrat39/symbols-outline.nvim` | `prev_cfg/init.lua` | Omitted; LazyVim symbol navigation is baseline. | Revisit if a persistent outline panel is wanted. | None. |
| `cshuaimin/ssr.nvim` | `prev_cfg/init.lua` | Omitted. | Revisit if structural search/replace is still wanted. | Treesitter parser coverage. |
| Optional Python type server: `pyright` or `pylsp` | `prev_cfg/lua/sohooo/lsp.lua` | Deferred; Python currently uses Ruff only. | Add only if Python type/completion support is needed beyond Ruff. | External `pyright` or `pylsp` on `PATH`. |
| Language-specific plugins: `vim-go`, `rust-tools.nvim`, `dbtpal` | `prev_cfg/init.lua` | Deferred; baseline LSP uses native `vim.lsp`. | Migrate one workflow at a time only if native LSP is insufficient. | External language tools supplied outside Mason. |
| `vim-go` globals from `misc.lua` | `prev_cfg/lua/sohooo/misc.lua` | Blocked. | Copy only if `vim-go` is reintroduced. | `vim-go` migrated. |
| Commented treesitter extras | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/treesitter.lua` | Not migrated; inactive in old baseline. | Promote individually only if a concrete treesitter workflow is wanted. | Parser/tooling coverage. |
| Commented Noice setup | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/noice.lua` | Not migrated from old config; LazyVim already includes its own UI choices. | Revisit only through LazyVim extras/UI policy. | UI preference. |
| Additional old colorschemes | `prev_cfg/init.lua` | Omitted. | Add only themes that are actively used. | Theme preference. |

## LazyVim overlap review

The direct overlap items from the first review were resolved and recorded in
`docs/migration-decisions.md`. Remaining items are intentionally distinct
workflows to revisit only if they become noisy or unused.

| Area | Current local piece | LazyVim/baseline overlap | Current impact | Suggested next action |
| --- | --- | --- | --- | --- |
| File explorer keys | `lua/plugins/snacks-explorer.lua` customizes Snacks explorer. | LazyVim already provides Snacks explorer as the default explorer extra. | Intentional key and behavior override, not a plugin duplicate. | Keep unless LazyVim upstream key behavior becomes preferable. |
| Completion/snippets | `mini.snippets` LazyVim extra with Blink completion. | LazyVim Blink baseline can work with multiple snippet engines depending on extras. | Intentional current snippet choice. | Keep unless snippet behavior requires LuaSnip or native snippets. |
| Quickfix editing | `quickfix-reflector.vim`. | LazyVim/Trouble/Snacks provide quickfix viewing and pickers, but not write-back editing. | Distinct capability with adjacent UI overlap. | Keep if editing quickfix lists is part of the workflow. |
| Git workflow | `vim-fugitive`, lazygit terminal, Snacks Git pickers, and Gitsigns. | LazyVim/Snacks already provide git pickers and terminal helpers. | Multiple Git interfaces with overlapping but distinct workflows. | Keep Fugitive while `:Git` command workflows are useful. |
