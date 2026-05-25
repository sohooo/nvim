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

## Current Tooling

| Area | Tool | How It Is Used | Requirement |
| --- | --- | --- | --- |
| Neovim | `nvim` | Launched by `scripts/nvim.sh`. | Installed binary or `NVIM_BIN` override. |
| Telescope FZF | `make` | Builds `telescope-fzf-native.nvim`. | Optional; plugin build is skipped when unavailable. |
| Terminal Git UI | `lazygit` | Used by `<leader>tg`. | Optional; mapping works when `lazygit` is on `PATH`. |
| Plugin sync | `git` | Used by lazy.nvim to clone/update plugins. | Required for plugin bootstrap/update. |
| Go LSP | `gopls` | Used by native `vim.lsp` for Go buffers. | Optional; install outside Neovim. |
| Python LSP | `ruff` | Used by native `vim.lsp` as `ruff server`. | Optional; install outside Neovim. |
| Rust LSP | `rust-analyzer` | Used by native `vim.lsp` for Rust buffers. | Optional; install outside Neovim. |
| Ruby LSP | `ruby-lsp` | Used by native `vim.lsp` for Ruby buffers. | Optional; install in the active Ruby environment. |
| Lua LSP | `lua-language-server` | Used by native `vim.lsp` for Lua buffers. | Optional; install outside Neovim. |
| Puppet LSP | `puppet-languageserver` | Used by native `vim.lsp` for Puppet buffers. | Optional; install Puppet Editor Services outside Neovim. |

Run the external tool check with:

```bash
make check-external-tools
```

The check fails only for required tools. Optional tools are reported so deferred
integrations can be evaluated without enabling auto-installers.

## Deferred AI CLI Integration

`folke/sidekick.nvim` is deferred. It can be reconsidered after the following
are explicitly configured:

- Copilot LSP setup using a binary supplied outside Mason.
- The AI CLI commands to expose, such as `codex`, `claude`, `gemini`, or
  another locally installed tool.
- A healthcheck or smoke test that verifies Sidekick loads without requiring
  Mason-managed downloads.
