-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
  disable_devicons = not Hifi(),
  color_devicons = true,
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      -- previewer = true,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
        n = {
          ["<c-d>"] = actions.delete_buffer,
        }
      }
    },
    find_files = {
      --theme = "dropdown"
    },
  },
  extensions = {
    -- Your extension config goes in here
  }
}

-- default mappings
-- https://github.com/nvim-telescope/telescope.nvim#default-mappings
-- Mappings	Action
-- <C-n>/<Down>	Next item
-- <C-p>/<Up>	Previous item
-- j/k	        Next/previous (in normal mode)
-- H/M/L	Select High/Middle/Low (in normal mode)
-- 'gg/G'	Select the first/last item (in normal mode)
-- <CR>	        Confirm selection
-- <C-x>	Go to file selection as a split
-- <C-v>	Go to file selection as a vsplit
-- <C-t>	Go to a file in a new tab
-- <C-u>	Scroll up in preview window
-- <C-d>	Scroll down in preview window
-- <C-/>	Show mappings for picker actions (insert mode)
-- ?	        Show mappings for picker actions (normal mode)
-- <C-c>	Close telescope
-- <Esc>	Close telescope (in normal mode)
-- <Tab>	Toggle selection and move to next selection
-- <S-Tab>	Toggle selection and move to prev selection
-- <C-q>	Send all items not filtered to qflist
-- <M-q>	Send all selected items to qflist

local M = {}

-- Falling back to find_files if git_files can't find a .git directory
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

return M

