# Plugin Migrations

Migrate the following plugins one by one by adding them to the correct position in `lua/plugins/`. Take inspiration from the old configuration under `prev_cfg/` regarding bindings (which-key) and settings for the current version of the plugin (where it makes sense).

After successful and verified integration of the plugin, move it from the `## todo` to the `## done` section below.
When the todo list is empty, promote the next deferred or omitted item by following `docs/migration-workflow.md`.


## done

- telescope
- which-key
- toggleterm
- focus.nvim
- vim-pasta
- vim-repeat
- quickfix-reflector.vim
- tabout.nvim
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
  - mini.bufremove (replaces bufdelete.nvim)
  - mini.splitjoin
  - mini.align
  - mini.jump (replaces vim-sneak)
  - mini.statusline (replaces lualine)
  - mini.tabline (replaces tabline)
  - mini.cursorword (replaces vim-illuminate)
  - mini.indentscope (replaces indent-blankline.nvim)
  - mini.trailspace
  - mini.icons
  - mini.snippets
  - mini.cmdline
  - mini.diff (replaces gitsigns.nvim)
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
- nvim-treesitter-context

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
| `folke/todo-comments.nvim` | `prev_cfg/init.lua`, `prev_cfg/lua/sohooo/todo-comments.lua` | Omitted. | Consider reintroducing if TODO/FIXME search is wanted. | None. |
| `sindrets/diffview.nvim` | `prev_cfg/init.lua` | Omitted; Mini diff and Fugitive cover the current Git baseline. | Revisit if file history/diff review UI is wanted. | Git workflow preference. |
| `levouh/tint.nvim` | `prev_cfg/init.lua` | Omitted; `focus.nvim` covers window focus behavior. | Revisit if inactive-window dimming is still wanted. | None. |
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
