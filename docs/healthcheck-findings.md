# Healthcheck Findings

This is the actionable baseline extracted from the latest captured report in
`docs/healthcheck.md`. These findings are not fixed automatically because Mason
is disabled and external binaries should be supplied explicitly.

## Current Baseline

| Section | Finding | Current Treatment |
| --- | --- | --- |
| `lazy` | LuaRocks reports missing Lua 5.1. | Accepted baseline; no active plugin requires LuaRocks. |
| `lazyvim` | `fzf` is missing. | Optional tool. Install externally if LazyVim picker integrations should use it. |
| `lazyvim` | `tree-sitter` CLI is missing. | External prerequisite for parser management. Install outside Mason before relying on parser updates. |
| `snacks.dashboard` | Healthcheck reports setup did not run. | Needs a focused LazyVim/Snacks review if dashboard support matters. |
| `snacks.image` | Terminal image tools are missing: `kitty`, `wezterm`, or `ghostty`. | Optional; required only for terminal graphics. |
| `snacks.image` | Image conversion tools are missing: `magick` or `convert`. | Optional; required for non-PNG image conversion. |
| `snacks.image` | Document render tools are missing: `gs`, `tectonic` or `pdflatex`, and `mmdc`. | Optional; required for PDF, LaTeX, and Mermaid image rendering. |
| `snacks.image` | Treesitter parsers are missing for docs/image rendering languages. | Optional until those render paths are used. |
| `snacks.image` | The current terminal does not support the kitty graphics protocol. | Environment-specific; Codex/headless runs may keep reporting this. |
| `snacks.input` | `vim.ui.input` is not set to `Snacks.input`. | Candidate config follow-up if Snacks input should be the active UI. |
| `snacks.notifier` | Notifier reports not ready during healthcheck. | Candidate config follow-up if notifications should be routed through Snacks. |
| `snacks.picker` | `vim.ui.select` is not set to `Snacks.picker.select`. | Candidate config follow-up if Snacks picker should own selection UI. |
| `snacks.picker` | `regex` parser is missing. | Optional parser follow-up. |
| `vim.provider` | Node, Perl, Python, and Ruby providers are missing or incomplete. | Optional providers. Install externally or disable intentionally if unused. |

## Follow-Up Order

1. Decide which optional Neovim providers are intentionally unsupported and
   disable only those providers explicitly.
2. Install or document required external parser/tooling binaries such as
   `tree-sitter` and `fzf`.
3. Review Snacks UI ownership for `vim.ui.input`, `vim.ui.select`, dashboard,
   and notifier behavior.
4. Re-run `make healthcheck` after each change and update `docs/healthcheck.md`.

