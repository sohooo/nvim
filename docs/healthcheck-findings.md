# Healthcheck Findings

This is the curated baseline extracted from the latest captured report in
`docs/healthcheck.md`. Mason is disabled, so missing external binaries are
tracked here instead of being auto-installed.

`make verify` runs `scripts/verify-healthcheck.sh` against the captured report
and fails when a new `ERROR` or `WARNING` appears outside this accepted
baseline. After intentionally accepting a new finding, update both this file
and the verifier pattern list.

Latest refresh:

| Command | Exit Status | Errors | Warnings |
| --- | --- | --- | --- |
| `make healthcheck` | `0` | `10` | `16` |

## Fixed Locally

| Finding | Resolution |
| --- | --- |
| Local `config` health module failed. | `lua/config/health.lua` now exposes a `check()` function for `:checkhealth config`. |
| `vim.ui.input` was not set to `Snacks.input`. | `lua/config/health.lua` enables `Snacks.input` after `VeryLazy`. |
| `vim.ui.select` was not set to `Snacks.picker.select`. | `lua/config/health.lua` assigns `Snacks.picker.select` after `VeryLazy`. |
| Native LSP reported unknown filetype `gotmpl`. | `lua/config/filetypes.lua` registers `.gotmpl` as `gotmpl`. |
| Native LSP reported unknown filetype `puppet`. | `lua/config/filetypes.lua` registers `.pp` as `puppet`. |
| Node, Perl, Python 3, and Ruby providers reported missing provider dependencies. | Unused providers are disabled in `lua/config/options.lua`. |

## External Dependencies

These findings are solved by installing binaries outside Neovim. They should
not be fixed by enabling Mason or auto-downloaders.

| Section | Finding | Treatment |
| --- | --- | --- |
| `lazyvim` | `fzf` is missing. | Optional but recommended for fuzzy picker integrations. |
| `lazyvim` | `tree-sitter` CLI is missing. | Optional for startup; install before parser maintenance or parser updates. |
| `vim.lsp` | `puppet-languageserver` is not executable. | Optional; required only for Puppet LSP support. |
| `vim.lsp` | `ruby-lsp` is not executable. | Optional; required only for Ruby LSP support. Install in the active Ruby environment. |
| `vim.lsp` | `rust-analyzer` is not executable. | Optional; required only for Rust LSP support. |
| `snacks.image` | Terminal graphics executables are missing: `kitty`, `wezterm`, or `ghostty`. | Optional; required only for Snacks image rendering in supported terminals. |
| `snacks.image` | Image conversion tools are missing: `magick` or `convert`. | Optional; required for non-PNG image conversion. |
| `snacks.image` | Document render tools are missing: `gs`, `tectonic` or `pdflatex`, and `mmdc`. | Optional; required for PDF, LaTeX, and Mermaid image rendering. |

## Optional UI And Image Capabilities

These are accepted until the corresponding feature becomes part of the active
baseline.

| Section | Finding | Current Treatment |
| --- | --- | --- |
| `snacks.dashboard` | Setup did not run during healthcheck. | Accepted for the current headless healthcheck baseline; revisit only if the dashboard becomes important. |
| `snacks.image` | Image rendering reports missing Treesitter parsers for render paths. | Optional until Snacks image rendering is enabled and used. |
| `snacks.image` | Current terminal does not support the kitty graphics protocol. | Environment-specific; expected in some terminals and headless runs. |
| `snacks.notifier` | Notifier reports not ready during healthcheck. | Accepted headless baseline unless notification routing breaks in an interactive session. |
| `snacks.picker` | `regex` Treesitter parser is missing. | Optional parser follow-up for picker highlighting. |
| `snacks.statuscolumn` | Setup is disabled. | Intentional; local `statuscolumn` settings keep editor panes stable. |

## Accepted Baseline Warnings

| Section | Finding | Reason |
| --- | --- | --- |
| `blink.cmp` | Some providers may show as disabled because they are enabled dynamically. | Upstream behavior; completion remains active. |
| `lazy` | LuaRocks reports missing Lua 5.1. | Accepted because the active plugin set does not rely on LuaRocks packages. |

## Follow-Up Order

1. Install external editor tools that improve daily use: `fzf`, `tree-sitter`,
   and any desired LSP binaries such as `ruby-lsp`, `rust-analyzer`, or
   `puppet-languageserver`.
2. Decide whether Snacks image rendering should be supported; if yes, install
   the terminal/image/document tools and missing parsers documented in
   `docs/external-tools.md`.
3. Re-run `make healthcheck` after each change and refresh
   `docs/healthcheck.md` plus this findings file.
