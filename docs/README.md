# Neovim Config Documentation

This directory documents the current LazyVim-based configuration.

- [Plugins](plugins.md): migrated plugin inventory and config locations.
- [Keymaps](keymaps.md): custom keymaps added on top of LazyVim defaults.
- [Settings](settings.md): option decisions migrated from `prev_cfg/init.lua`.
- [LSP](lsp.md): native Neovim LSP setup using externally installed binaries.
- [External tools](external-tools.md): policy for LSP servers, formatters, linters, debuggers, and AI CLIs.
- [Healthcheck](healthcheck.md): latest captured `:checkhealth` report.
- [Healthcheck findings](healthcheck-findings.md): actionable baseline extracted from the current report.
- [Migration decisions](migration-decisions.md): mapping from `prev_cfg/` plugins to the LazyVim baseline.
- [Migration workflow](migration-workflow.md): process for promoting and verifying future plugin migrations.

The entry point is [`../init.lua`](../init.lua). LazyVim setup lives in
[`../lua/config/lazy.lua`](../lua/config/lazy.lua), local plugin specs live in
[`../lua/plugins/`](../lua/plugins/), and project-local startup goes through
[`../scripts/nvim.sh`](../scripts/nvim.sh).
