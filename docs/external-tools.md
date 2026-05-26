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
| `rg` | Snacks picker, LazyVim health | Fast text search for live grep and word search. | Optional, strongly recommended for `<leader>s`, `<leader>S`, and search pickers. |
| `fd` | Snacks picker, LazyVim health | Fast file discovery. | Optional, strongly recommended for file pickers. |
| `fzf` | LazyVim/Snacks integrations | Fuzzy filtering support where available. | Optional; healthcheck may warn if missing. |
| `trash` | Snacks/LazyVim file actions | Move deleted files to the system trash when file actions use it. | Optional; direct buffer deletion does not require it. |
| `lazygit` | `lua/plugins/snacks-terminal.lua` | Floating terminal Git UI on `<leader>tg`. | Optional; mapping works when `lazygit` is on `PATH`. |

## LSP Binaries

Native LSP configs live in `lua/config/lsp.lua`. Mason is disabled, so each
server only works when its binary is already available on `PATH`.

| Language | Tool | Command | Requirement |
| --- | --- | --- | --- |
| Go | `gopls` | `gopls` | Optional; required for Go LSP features. |
| Python | `ruff` | `ruff server` | Optional; required for Python Ruff LSP features. |
| Rust | `rust-analyzer` | `rust-analyzer` | Optional; required for Rust LSP features. |
| Ruby | `ruby-lsp` | `ruby-lsp` | Optional; required for Ruby LSP features. Install in the active Ruby environment. |
| Lua | `lua-language-server` | `lua-language-server` | Optional; required for Lua LSP features. |
| Puppet | `puppet-languageserver` | `puppet-languageserver --stdio ...` | Optional; required for Puppet LSP features. |

See [LSP](lsp.md) for server filetypes, root markers, and server-specific
configuration.

## Parser And Build Tools

| Tool | Used By | Purpose | Requirement |
| --- | --- | --- | --- |
| `tree-sitter` | nvim-treesitter | Builds or updates parsers. | Optional for startup; install before parser maintenance. |
| `make` | Plugin build hooks and local build tasks | Runs native plugin or project build commands when needed. | Optional for current startup; useful for plugin maintenance. |

Run the external tool check with:

```bash
make check-external-tools
```

The check fails only for required tools. Optional tools are reported so deferred
integrations can be evaluated without enabling auto-installers.

## Deferred AI CLI Tools

These tools are not active baseline dependencies. They are tracked because the
deferred Sidekick/Copilot work may use them later.

| Tool | Used By | Requirement |
| --- | --- | --- |
| `codex` | Future Sidekick or AI CLI integration. | Optional. |
| `claude` | Future Sidekick or AI CLI integration. | Optional. |
| `gemini` | Future Sidekick or AI CLI integration. | Optional. |
| `copilot-language-server` | Future Copilot LSP setup. | Optional. |

## Deferred AI CLI Integration

`folke/sidekick.nvim` is deferred. It can be reconsidered after the following
are explicitly configured:

- Copilot LSP setup using a binary supplied outside Mason.
- The AI CLI commands to expose, such as `codex`, `claude`, `gemini`, or
  another locally installed tool.
- A healthcheck or smoke test that verifies Sidekick loads without requiring
  Mason-managed downloads.
