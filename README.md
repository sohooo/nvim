# Neovim Config

LazyVim-based Neovim configuration with project-local startup, plugin state,
and cache directories.

## Run

Use the wrapper script so Neovim sees this repository as its config and stores
runtime state under `.xdg/`:

```bash
scripts/nvim.sh
```

To use a specific Neovim binary:

```bash
NVIM_BIN=/path/to/nvim scripts/nvim.sh
```

## First Run Checklist

1. Start Neovim once with `scripts/nvim.sh` so lazy.nvim can bootstrap plugins.
2. Run `make verify` to check startup, plugin smoke tests, and external tools.
3. Run `make check-external-tools` to see optional local binaries used by LSP,
   terminal, and AI integrations.
4. Run `make healthcheck` when you want to refresh the captured health report.

## Verify

Run the headless startup test:

```bash
tests/run.sh
```

The test fails on startup errors or warnings.

Run the broader migrated-plugin smoke checks:

```bash
make verify-plugins
```

Run all local baseline checks:

```bash
make verify
```

Check external tools expected by optional integrations:

```bash
make check-external-tools
```

Show the current plugin migration queue:

```bash
make migration-status
```

Capture a healthcheck report:

```bash
make healthcheck
```

## Tooling Policy

Mason is disabled. Language servers, formatters, linters, debuggers, and AI CLI
tools should be installed outside this config and discovered on `PATH`.

See [docs/external-tools.md](docs/external-tools.md) for details.

Known accepted healthcheck warnings are tracked in
[docs/healthcheck-findings.md](docs/healthcheck-findings.md). Missing optional
tools should be installed outside Neovim or left documented as accepted
follow-up work.

## Documentation

- [PORTABLE.md](PORTABLE.md)
- [docs/plugins.md](docs/plugins.md)
- [docs/keymaps.md](docs/keymaps.md)
- [docs/settings.md](docs/settings.md)
- [docs/customization-guide.md](docs/customization-guide.md)
- [docs/lsp.md](docs/lsp.md)
- [docs/external-tools.md](docs/external-tools.md)
- [docs/healthcheck.md](docs/healthcheck.md)
- [docs/healthcheck-findings.md](docs/healthcheck-findings.md)
- [docs/migration-decisions.md](docs/migration-decisions.md)
- [docs/migration-workflow.md](docs/migration-workflow.md)
