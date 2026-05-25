# Customization Guide

This config is a LazyVim baseline with local behavior layered on top. Keep new
changes close to the runtime owner so lazy-loading and documentation stay
predictable.

## Where Changes Belong

| Change | Location | Notes |
| --- | --- | --- |
| Editor options | `lua/config/options.lua` | Use for `vim.opt` and global editor policy. |
| Global non-plugin keymaps | `lua/config/keymaps.lua` | Use for mappings that do not belong to a plugin. |
| Small global commands | `lua/config/misc.lua` | Use for typo aliases and tiny commands that are always available. |
| Shared helper functions | `lua/config/<name>.lua` | Use only when more than one module needs the helper. |
| Plugin setup and plugin-owned keymaps | `lua/plugins/<plugin>.lua` | Prefer lazy.nvim `keys`, `cmd`, `event`, and `opts` fields. |
| Which-key metadata | `lua/plugins/which-key.lua` | Add group labels and descriptions only; runtime mappings stay with their owner. |
| Native LSP servers and LSP keymaps | `lua/config/lsp.lua` | Use `vim.lsp.config` and `vim.lsp.enable`; do not add `nvim-lspconfig`. |
| External binaries | `docs/external-tools.md` and `scripts/check-external-tools.sh` | Tools must be installed outside Neovim because Mason is disabled. |
| Migration decisions | `TODO.md` and `docs/migration-decisions.md` | Track why plugins are migrated, replaced, deferred, or omitted. |

The original LazyVim starter template is not kept in this repository. Use the
[LazyVim documentation](https://www.lazyvim.org/configuration) as the upstream
reference when adding new LazyVim-style plugin specs.

## Examples

Add a non-plugin keymap in `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>x", function()
  vim.cmd.nohlsearch()
end, { desc = "Clear Search Highlight" })
```

Add a plugin-owned keymap in `lua/plugins/example-plugin.lua`:

```lua
return {
  {
    "owner/example.nvim",
    keys = {
      { "<leader>tx", "<cmd>ExampleToggle<cr>", desc = "Example Toggle" },
    },
    opts = {},
  },
}
```

Add a shared helper under `lua/config/` only when multiple modules need it:

```lua
local M = {}

function M.enabled()
  return vim.env.MY_FEATURE ~= "0"
end

return M
```

Then use it from a plugin spec:

```lua
local feature = require("config.feature")

return {
  {
    "owner/example.nvim",
    enabled = feature.enabled(),
  },
}
```

Add a native LSP server in `lua/config/lsp.lua`:

```lua
vim.lsp.config("example_ls", {
  cmd = { "example-language-server" },
  filetypes = { "example" },
  root_markers = { "example.toml", ".git" },
})

vim.lsp.enable({ "example_ls" })
```

After adding an external binary, also update `docs/external-tools.md` and
`scripts/check-external-tools.sh`.

## Verification Checklist

After changing config behavior, run:

```bash
make verify
```

Run focused checks when relevant:

```bash
scripts/nvim.sh --headless "+lua require('config.lsp')" +qa
scripts/nvim.sh --headless "+checkhealth vim.lsp" +qa
make check-external-tools
make healthcheck
```

Existing healthcheck warnings are tracked in `docs/healthcheck-findings.md`.
Treat them as follow-up work unless your change introduces a new warning or
changes the external-tool policy.
