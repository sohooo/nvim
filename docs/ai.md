# AI-Assisted Coding

AI support is terminal-first and uses the external `crush` CLI. No Neovim AI
plugin is active, no provider credentials live in this repo, and Node.js is not
a required dependency.

Crush must be installed on `PATH` and configured outside Neovim for the desired
local or remote inference endpoint. Missing `crush` only shows a warning when a
Crush mapping is used; it does not break startup.

## Workflow

| Key | Action |
| --- | --- |
| `,aa` | Open interactive Crush at the project root. |
| `,aA` | Continue the latest interactive Crush session. |
| visual `,as` | Ask Crush about the selected lines. |
| visual `,aS` | Ask Crush about the selected lines and continue the latest session. |
| `,af` | Ask Crush about the current file. |
| `,aF` | Ask Crush about the current file and continue the latest session. |
| `,al` | Open Crush logs. |
| `,am` | List available Crush models. |

Selection and current-file commands prompt for a question with `vim.ui.input`,
write temporary context under Neovim's runtime directory, and pipe that context
to `crush run`. The `continue` variants use `crush run --continue`, so they can
append context to the latest session without relying on terminal paste behavior.

Useful external checks:

```bash
crush --version
crush dirs
crush models
crush --cwd /path/to/project
crush run --continue "Follow up with this context"
```

## Plugin Evaluation

| Candidate | Decision | Reason |
| --- | --- | --- |
| Crush via Snacks terminal | Active workflow | Keeps Neovim integration small, works with local inference endpoints, and avoids adding a second in-editor agent framework. |
| `olimorris/codecompanion.nvim` | Good future candidate | Maintained Neovim-native assistant plugin with multiple contributors and no Node.js requirement in the editor plugin itself. |
| `frankroeder/parrot.nvim` | Lightweight fallback | Useful if a smaller chat/prompt workflow is preferred over a broader assistant framework. |
| `Robitx/gp.nvim` | Defer | Viable, but less aligned with a Crush-first workflow. |
| `yetone/avante.nvim` | Do not add now | Heavier in-editor agent layer with more overlap against Crush. |
| Vendor/cloud completion plugins | Out of scope | They do not match the local endpoint and no-Node requirement. |

## External Tools

`crush` is listed as an optional external tool in `docs/external-tools.md` and
checked by `make check-external-tools`. Airgap bundles do not include AI CLIs;
install and configure Crush separately on each host.
