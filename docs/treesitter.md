# Treesitter

Treesitter is provided by LazyVim through `nvim-treesitter`. Local parser policy
lives in `lua/plugins/treesitter.lua`.

## Parser Set

The local baseline explicitly asks nvim-treesitter to install parsers for shell,
YAML, and every language with a native LSP server in `lua/config/lsp.lua`.

| Area | Filetypes | Parser | Notes |
| --- | --- | --- | --- |
| Shell | `sh` | `bash` | `sh` is registered to the `bash` parser because nvim-treesitter does not provide a separate `sh` parser. |
| YAML | `yaml` | `yaml` | Used by config and infrastructure files. |
| Go | `go` | `go` | Matches `gopls`. |
| Go modules | `gomod` | `gomod` | Matches `gopls` Go module file support. |
| Go sums | `gosum` | `gosum` | Matches `gopls` Go sum file support. |
| Go templates | `gotmpl` | `gotmpl` | Matches `gopls` Go template file support. |
| Python | `python` | `python` | Matches Ruff LSP. |
| Rust | `rust` | `rust` | Matches `rust-analyzer`. |
| Ruby | `ruby` | `ruby` | Matches Ruby LSP. |
| ERB | `eruby` | `embedded_template` | `eruby` is registered to the `embedded_template` parser. |
| Lua | `lua` | `lua` | Matches Lua Language Server. |
| Puppet | `puppet` | `puppet` | Matches Puppet Language Server. |

## External Tooling

Parser installation and updates may require the external `tree-sitter` CLI. This
project does not install it automatically because Mason is disabled. Missing
parser tooling should be handled outside Neovim and is reported by:

```bash
make check-external-tools
```

## Verification

`make verify` checks that:

- the local parser list is present in the effective `nvim-treesitter` config;
- requested parsers are known by nvim-treesitter;
- `sh` and `eruby` resolve to their registered parser aliases;
- installed requested parsers can be created in a scratch buffer.

The verification does not fail just because optional parsers are not installed
yet. Parser installation is an external-tooling step and depends on
`tree-sitter` being available.
