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
| `solargraph` | Ruby, ERB | `solargraph stdio` | `Gemfile`, `.git` | Restored from `prev_cfg/lua/sohooo/lsp.lua`. | Install `solargraph` in the active Ruby environment. |
| `lua_ls` | Lua | `lua-language-server` | `.luarc.json`, `.luarc.jsonc`, `.luacheckrc`, `.stylua.toml`, `stylua.toml`, `selene.toml`, `selene.yml`, `.git` | Migrated from the old Lua LS setup. | Install Lua Language Server outside Neovim. |
| `puppet` | Puppet | `puppet-languageserver --stdio --timeout=10 --puppet-settings=--modulepath,/modules --local-workspace=$HOME/puppetenvs/kpm` | `metadata.json`, `Puppetfile`, `.git` | Migrated from the old Puppet setup. | Install Puppet Editor Services outside Neovim. |

## Ruby

Ruby uses Solargraph again. This intentionally avoids Ruby LSP's composed-bundle
management and matches the old config's `solargraph` server choice, while still
using Neovim's native `vim.lsp.config` API instead of `nvim-lspconfig`.

The command is `solargraph stdio`. Open Neovim from a shell where the intended
Ruby environment is already active and `solargraph` is available on `PATH`.

If Solargraph does not attach, check the same command outside Neovim from the
project root:

```bash
ruby -v
solargraph --version
solargraph stdio
```

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
without requiring any optional server binary to exist.
