# External Tools Policy

Mason is disabled in this config. Neovim may use language servers, formatters,
linters, debuggers, Git tools, and AI command-line tools when they are already
available on `PATH`, but the config should not auto-download them.

## Rules

- Do not enable Mason-managed installation.
- Prefer system package managers, project-local toolchains, or explicit user
  installation outside this repo for binaries.
- Plugin specs may configure Neovim integrations, but must tolerate missing
  external executables without startup warnings.
- Any future LSP, formatter, linter, DAP, or AI CLI integration should document
  the binary name, expected command, and verification command.
- Healthcheck warnings for missing optional binaries should be tracked as
  follow-up work, not hidden by auto-installing tools.

## Required Tools

These tools are required for normal project-local startup and plugin
bootstrap/update workflows.

| Tool | Used By | Purpose | Notes |
| --- | --- | --- | --- |
| `nvim` | `scripts/nvim.sh` | Starts Neovim with this repository as the config. | Can be overridden with `NVIM_BIN=/path/to/nvim`. |
| `git` | lazy.nvim | Clones, restores, syncs, and updates plugins. | Required for first bootstrap and later plugin maintenance. |

## Recommended Editor Tools

These tools are optional for startup, but important for the day-to-day editor
experience. Missing tools should degrade features instead of breaking startup.

| Tool | Used By | Purpose | Requirement |
| --- | --- | --- | --- |
| `rg` | Snacks picker, LazyVim health | Fast text search for live grep and word search. | Optional, strongly recommended for `,s`, `,S`, and search pickers. |
| `fd` | Snacks picker, LazyVim health | Fast file discovery. | Optional, strongly recommended for file pickers. |
| `fzf` | LazyVim/Snacks integrations | Fuzzy filtering support where available. | Optional; healthcheck may warn if missing. |
| `trash` | Snacks/LazyVim file actions | Move deleted files to the system trash when file actions use it. | Optional; direct buffer deletion does not require it. |
| `lazygit` | `lua/plugins/snacks-terminal.lua` | Floating terminal Git UI on `,tg`. | Optional; mapping works when `lazygit` is on `PATH`. |

## LSP Binaries

Native LSP configs live in `lua/config/lsp.lua`. Mason is disabled, so each
server only works when its binary is already available on `PATH`.

| Language | Tool | Command | Requirement |
| --- | --- | --- | --- |
| Go | `gopls` | `gopls` | Optional; required for Go LSP features. |
| Python | `ruff` | `ruff server` | Optional; required for Python Ruff LSP features. |
| Rust | `rust-analyzer` | `rust-analyzer` | Optional; required for Rust LSP features. |
| Ruby | `ruby-lsp` | `ruby-lsp` | Optional; required for Ruby language-server features. Install in the active Ruby environment; override with `RUBY_LSP_CMD` when a version-manager shim is needed. |
| Lua | `lua-language-server` | `lua-language-server` | Optional; required for Lua LSP features. |
| Puppet | `puppet-languageserver` | `puppet-languageserver --stdio ...` | Optional; required for Puppet LSP features. The local workspace defaults to `<effective-home>/puppetenvs/kpm`; override with `PUPPET_LSP_WORKSPACE`. |

See [LSP](lsp.md) for server filetypes, root markers, and server-specific
configuration.

Ruby LSP has an optional integration fixture. Run `make verify-ruby-lsp` after
installing `ruby-lsp` to confirm attachment and basic LSP requests against the
demo project in `tests/fixtures/ruby-lsp-demo`.

## Parser And Build Tools

| Tool | Used By | Purpose | Requirement |
| --- | --- | --- | --- |
| `tree-sitter` | nvim-treesitter | Builds or updates parsers. | Optional for startup; install before parser maintenance. |
| `make` | Plugin build hooks and local build tasks | Runs native plugin or project build commands when needed. | Optional for current startup; useful for plugin maintenance. |

## Optional Image And Render Tools

Snacks image rendering is optional. Missing tools are documented by
`make healthcheck`, but they should not block startup or normal editing.

| Tool | Used By | Purpose | Requirement |
| --- | --- | --- | --- |
| `kitty`, `wezterm`, or `ghostty` | Snacks image | Terminal graphics support. | Optional; required only for inline image rendering in supported terminals. |
| `magick` or `convert` | Snacks image | Converts non-PNG image formats. | Optional; required only for broader image format support. |
| `gs` | Snacks image | Renders PDF files. | Optional; required only for PDF image rendering. |
| `tectonic` or `pdflatex` | Snacks image | Renders LaTeX math expressions. | Optional; required only for LaTeX image rendering. |
| `mmdc` | Snacks image | Renders Mermaid diagrams. | Optional; required only for Mermaid image rendering. |

## Disabled Neovim Providers

The Node, Perl, Python 3, and Ruby providers are disabled in
`lua/config/options.lua`. This keeps the healthcheck baseline clean because this
config does not use remote plugins that require those providers. Re-enable a
provider only when adding a plugin or workflow that explicitly needs it, then
install the provider package externally.

Run the external tool check with:

```bash
make check-external-tools
```

The check fails only for required tools. Optional tools are reported so deferred
integrations can be evaluated without enabling auto-installers.

## Optional AI CLI Tools

These tools are not active baseline dependencies. AI integrations should use
locally installed CLIs or local endpoints and must not make Node.js a required
dependency for this config.

| Tool | Used By | Requirement |
| --- | --- | --- |
| `crush` | Active terminal-first AI workflow on `,a...` mappings. | Optional. |
| `codex` | Future AI CLI integration. | Optional. |
| `claude` | Future AI CLI integration. | Optional. |
| `gemini` | Future AI CLI integration. | Optional. |

## AI Integration Policy

The active AI workflow is a small Crush integration through Snacks terminal
mappings, with CodeCompanion or Parrot kept as possible future Neovim-native
options. See [AI-assisted coding](ai.md).

Node-required AI plugins and Copilot-first workflows are out of scope for the
current baseline.
