# LSP Configuration

Language servers are configured with Neovim's native `vim.lsp.config` and
`vim.lsp.enable` APIs in `lua/config/lsp.lua`. Mason and `nvim-lspconfig` are
disabled; every server binary must already be available on `PATH`.

## Servers

| Server | Languages | Command | Root markers | Source | Install responsibility |
| --- | --- | --- | --- | --- | --- |
| `gopls` | Go, Go modules, Go sums, Go templates | `gopls` | `go.work`, `go.mod`, `.git` | Migrated from `prev_cfg/lua/sohooo/lsp.lua`. | Install `gopls` outside Neovim. |
| `ruff` | Python | `ruff server` | `pyproject.toml`, `ruff.toml`, `.ruff.toml`, `setup.py`, `setup.cfg`, `requirements.txt`, `.git` | Migrated from the old active Ruff setup. | Install `ruff` outside Neovim. |
| `rust_analyzer` | Rust | `rust-analyzer` | `Cargo.toml`, `rust-project.json`, `.git` | Migrated from `prev_cfg/lua/sohooo/lsp.lua`. | Install `rust-analyzer` outside Neovim. |
| `ruby_lsp` | Ruby, ERB | `ruby-lsp` | `Gemfile`, `.git` | Replaces the old Solargraph setup with Shopify Ruby LSP. | Install `ruby-lsp` in the active Ruby environment. |
| `lua_ls` | Lua | `lua-language-server` | `.luarc.json`, `.luarc.jsonc`, `.luacheckrc`, `.stylua.toml`, `stylua.toml`, `selene.toml`, `selene.yml`, `.git` | Migrated from the old Lua LS setup. | Install Lua Language Server outside Neovim. |
| `puppet` | Puppet | `puppet-languageserver --stdio --timeout=10 --puppet-settings=--modulepath,/modules --local-workspace=<effective-home>/puppetenvs/kpm` | `metadata.json`, `Puppetfile`, `.git` | Migrated from the old Puppet setup. | Install Puppet Editor Services outside Neovim. |

## Ruby

Ruby uses Shopify Ruby LSP through Neovim's native `vim.lsp.config` API. The
command is `ruby-lsp` by default and is executed directly from `PATH`, not
through Mason or `bundle exec`. This matches the external-binaries policy and
keeps Ruby version management in the shell or project environment.

Override the executable with `RUBY_LSP_CMD=/absolute/path/to/ruby-lsp` when a
version manager requires an explicit shim. Open Neovim from a shell where the
intended Ruby environment is already active.

If Ruby LSP does not attach, check the same command outside Neovim from the
project root:

```bash
ruby -v
ruby-lsp --version
ruby-lsp --doctor
```

The local verification fixture lives in `tests/fixtures/ruby-lsp-demo`. Run
`make verify-ruby-lsp` to attach Ruby LSP to that demo project and exercise
definition, hover, document symbols, references, and advertised capabilities.
The check skips cleanly when `ruby-lsp` is not installed.

### Ruby LSP Troubleshooting

When Ruby LSP does not attach or exits early, first confirm Neovim sees the
Ruby buffer correctly:

```vim
:set filetype?
:LspInfo
:checkhealth vim.lsp
```

Expected results are `filetype=ruby`, an attached `ruby_lsp` client in
`:LspInfo`, and a `ruby_lsp` section in `:checkhealth vim.lsp` without an
executable warning.

For more verbose Neovim-side logs, raise the native LSP log level before
reopening the Ruby file:

```vim
:lua vim.lsp.set_log_level("debug")
:LspLog
```

`LspLog` opens Neovim's native LSP log file. Start Neovim with debug logging
from the shell when reproducing startup-only failures:

```bash
scripts/nvim.sh --cmd 'lua vim.lsp.set_log_level("debug")'
```

Ruby LSP also provides its own diagnostics. Run these from the Ruby project
root, using the same shell and Ruby environment used to start Neovim:

```bash
ruby -v
ruby-lsp --version
ruby-lsp --doctor
```

Common causes are `ruby-lsp` missing from `PATH`, a different Ruby version in
Neovim than in the shell, project bundle issues, or Ruby LSP composed-bundle
setup failures. This config invokes `ruby-lsp` directly; use `RUBY_LSP_CMD` only
when a version manager needs an explicit shim path.

## Puppet

Puppet uses `puppet-languageserver` from `PATH`. The default local workspace is
`<effective-home>/puppetenvs/kpm`, resolved with Neovim/libuv instead of raw
`$HOME` so sudo/root sessions do not accidentally target the invoking user's
home. Override it explicitly with `PUPPET_LSP_WORKSPACE=/path/to/workspace`
when needed.

## Diagnostics And Keymaps

Diagnostics keep the old rounded floating windows, custom signs, warning-level
virtual text, disabled underlines, insert-mode updates, and severity sorting.

LSP buffer-local mappings are registered on `LspAttach`:

| Mapping | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | References |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gD` | Go to declaration |
| `K` | Hover |
| `gK`, `<C-k>` in insert mode | Signature help |
| `,ca` | Code action |
| `,cr` | Rename |
| `,cl` | `:checkhealth vim.lsp` |

Native helper commands are available even without `nvim-lspconfig`:

| Command | Action |
| --- | --- |
| `:LspInfo` | Show clients attached to the current buffer. |
| `:LspLog` | Open Neovim's native LSP log file. |

## Verification

Run the local verification target:

```bash
make verify
```

The smoke checks verify that all native LSP configs are registered, Blink
completion capabilities are present, and the attach keymaps are installed
without requiring any optional server binary to exist. `make verify-ruby-lsp`
adds an optional integration check when `ruby-lsp` is available on `PATH`.
