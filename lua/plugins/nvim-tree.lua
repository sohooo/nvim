local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeFindFile",
      "NvimTreeFocus",
      "NvimTreeToggle",
    },
    keys = {
      { "mf", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal File In Tree" },
    },
    opts = {
      on_attach = on_attach,
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    },
  },
}
