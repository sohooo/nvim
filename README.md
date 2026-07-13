# Neovim Config

LazyVim-based Neovim configuration with project-local startup, plugin state,
and cache directories.

Current baseline:

- LazyVim with local overrides under `lua/`.
- Comma is the leader key.
- Snacks provides pickers, file explorer, terminal integration, and UI prompts.
- Mason is disabled; LSP and tool binaries come from `PATH`.
- Native `vim.lsp` config lives in this repo.
- Linux x86_64 airgap builds support a GitHub release AppImage and a local
  extracted tarball.

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

## Plugins And Keybinds

The full plugin inventory lives in [docs/plugins.md](docs/plugins.md). This is
the quick map for day-to-day use.

| Area | Plugins | Source | Main keys |
| --- | --- | --- | --- |
| Plugin/runtime foundation | `lazy.nvim`, `LazyVim`, `lazydev.nvim`, `persistence.nvim`, `plenary.nvim` | LazyVim plus local bootstrap | `:Lazy` |
| Completion and snippets | `blink.cmp`, `mini.snippets`, `friendly-snippets` | LazyVim | Completion appears in insert mode. |
| Files, buffers, search | `snacks.nvim` pickers/explorer, `todo-comments.nvim`, `flash.nvim`, `trouble.nvim`, `grug-far.nvim` | LazyVim with local key overrides | `,f`, `,F`, `,s`, `,S`, `,b`, `,d`, `mf`, `,psr`, `,pst`, `,psT` |
| UI and navigation | `which-key.nvim`, `noice.nvim`, `nvim-treesitter-context`, `lualine.nvim`, `bufferline.nvim`, `mini.icons` | LazyVim with local overrides | `,tc`, `,psn...`, `<Tab>`, `<S-Tab>`, `,B...` |
| Editing | `mini.surround`, `mini.ai`, `mini.comment`, `mini.pairs`, `mini.align`, `mini.splitjoin`, `mini.trailspace`, native `nvim.undotree` | LazyVim plus local Mini/native setup | `gc`, `gsa`, `gsd`, `gsr`, `ga`, `gA`, `gS`, `,cw`, `,u`, `,q` |
| Git and terminal | `gitsigns.nvim`, `vim-fugitive`, `vim-dispatch`, `snacks.nvim` terminal, `nvim-unception` | LazyVim plus local additions | `,tg`, `,te`, `,tt`, `:Git`, `:Dispatch`, `:Make` |
| AI terminal workflow | External `crush` CLI through `snacks.nvim` terminal | Local helper, host-provided CLI | `,aa`, `,aA`, `,af`, `,aF`, visual `,as`, visual `,aS` |
| LSP, formatting, linting | Native `vim.lsp`, `conform.nvim`, `nvim-lint` | Local native LSP plus LazyVim integrations | `gd`, `gr`, `K`, `gK`, `,ca`, `,cr`, `,cl` |
| Treesitter | `nvim-treesitter`, `nvim-treesitter-textobjects`, `nvim-ts-autotag`, `nvim-ts-context-commentstring`, `ts-comments.nvim` | LazyVim with local parser list | Syntax, textobjects, comments, and context header are automatic. |
| Themes | `tokyonight.nvim`, `nord-vim`, `catppuccin`, `kanagawa.nvim` | LazyVim plus local theme profiles | `,tc` |

Most important keys:

| Key | Action |
| --- | --- |
| `,f` / `,s` / `,b` | Find files, grep text, or pick buffers instantly. |
| `,F` / `,S` | Limit file or grep search to a chosen directory. |
| `,d` / `mf` | Open the project tree or reveal the current file in it. |
| `<Tab>` / `<S-Tab>` | Move through buffers in the tabline. |
| `,q` / `,B...` | Close the current buffer or use buffer-management actions. |
| `gd`, `gr`, `K`, `,ca`, `,cr` | LSP navigation, references, hover, code action, and rename. |
| `ga`, `gA`, `gS`, `gsa`, `gsd`, `gsr`, `gc` | Align, split/join, surround, and comment editing helpers. |
| `,te`, `,tt`, `,tg` | Open terminal and lazygit workflows. |
| `,aa`, `,af`, visual `,as` | Open Crush, ask about the current file, or ask about selected lines. |
| `,u`, `,cw`, `,tc` | Undo tree, trim trailing whitespace, and colorscheme picker. |

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

This includes airgap path tests, documentation link checks, external tool
reporting, shell script syntax/ShellCheck when available, accepted healthcheck
finding verification, plugin smoke tests, and the optional Ruby LSP demo check.

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

Build and verify a local Linux x86_64 airgap tarball:

```bash
make airgap-bundle
make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz
```

Build and verify a local Linux x86_64 release-style AppImage:

```bash
make airgap-appimage
make verify-airgap-appimage APPIMAGE=dist/nvim-airgap-linux-x86_64.AppImage
```

The GitHub Actions workflow builds the AppImage from Fedora userspace,
publishes a versioned release named `airgap-YYYY.MM.DD-<short-sha>`, and also
updates the moving `latest` release. Use the versioned release when you need a
stable artifact reference, and `latest` when you want the newest successful
build.

Run the release AppImage normally:

```bash
chmod +x nvim-airgap-linux-x86_64.AppImage
./nvim-airgap-linux-x86_64.AppImage
```

Run it on systems without FUSE support:

```bash
chmod +x nvim-airgap-linux-x86_64.AppImage
./nvim-airgap-linux-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
```

The AppImage uses bundled config and plugin data, but writes state, cache,
runtime sockets, and temporary files to per-effective-user locations:
`<effective-home>/.local/state/nvim-airgap`,
`<effective-home>/.cache/nvim-airgap`, and
`${TMPDIR:-/tmp}/nvim-airgap-<effective-uid>`. The launcher resolves
`<effective-home>` from the effective UID instead of trusting inherited
`$HOME`, so `sudo`/root sessions use root's home and do not create root-owned
files in the invoking user's directories. Override these with
`NVIM_AIRGAP_STATE_HOME`, `NVIM_AIRGAP_CACHE_HOME`, or
`NVIM_AIRGAP_RUNTIME_DIR` when needed.

If an older AppImage already created root-owned files in your normal user's
home, remove the cache/state once or change ownership before running as that
user again.

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
- [docs/airgap-bundle.md](docs/airgap-bundle.md)
- [docs/ai.md](docs/ai.md)
- [docs/plugins.md](docs/plugins.md)
- [docs/keymaps.md](docs/keymaps.md)
- [docs/settings.md](docs/settings.md)
- [docs/customization-guide.md](docs/customization-guide.md)
- [docs/lsp.md](docs/lsp.md)
- [docs/treesitter.md](docs/treesitter.md)
- [docs/external-tools.md](docs/external-tools.md)
- [docs/healthcheck.md](docs/healthcheck.md)
- [docs/healthcheck-findings.md](docs/healthcheck-findings.md)
- [docs/migration-decisions.md](docs/migration-decisions.md)
- [docs/migration-workflow.md](docs/migration-workflow.md)
