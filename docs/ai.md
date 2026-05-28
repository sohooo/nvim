# AI-Assisted Coding

No AI plugin is active in the runtime baseline yet. AI tools must follow the
same external-binary policy as LSP servers: install them outside this config,
put them on `PATH`, and do not add Node.js as a required dependency.

## Current Direction

Use Crush as the preferred next integration. It already fits the requested
workflow: AI-assisted coding through a local endpoint, driven by an external
CLI that Neovim can open in a Snacks terminal. The planned Neovim integration is
small: mappings and commands that launch `crush` when it is available.

Recommended first mappings for a future implementation:

| Key | Action |
| --- | --- |
| `,ta` | Open Crush in a project-root terminal. |
| `,tA` | Continue or resume a Crush session, depending on the installed CLI support. |

## Plugin Evaluation

| Candidate | Decision | Reason |
| --- | --- | --- |
| Crush via Snacks terminal | Preferred next step | Keeps Neovim integration small, works with local inference endpoints, and avoids adding a second in-editor agent framework. |
| `olimorris/codecompanion.nvim` | Good future candidate | Maintained Neovim-native assistant plugin with multiple contributors and no Node.js requirement in the editor plugin itself. |
| `frankroeder/parrot.nvim` | Lightweight fallback | Useful if a smaller chat/prompt workflow is preferred over a broader assistant framework. |
| `Robitx/gp.nvim` | Defer | Viable, but less aligned with a Crush-first workflow. |
| `yetone/avante.nvim` | Do not add now | Heavier in-editor agent layer with more overlap against Crush. |
| Vendor/cloud completion plugins | Out of scope | They do not match the local endpoint and no-Node requirement. |

## External Tools

`crush` should be documented and checked as an optional external tool when the
runtime mapping is added. Missing AI tools must not fail startup.
