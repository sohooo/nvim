-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  api.config.mappings.default_on_attach(bufnr)

  --  keymap overrides
  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

