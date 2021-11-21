require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',  -- moonlight | material-nvim | nord | aquarium | tokyonight
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    --lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'hostname'},
    --lualine_y = {'diagnostics'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    --lualine_a = {},
    --lualine_b = {},
    --lualine_c = { require'tabline'.tabline_buffers },
    --lualine_x = { require'tabline'.tabline_tabs },
    --lualine_y = {},
    --lualine_z = {},
  },
  extensions = {}
}

require'tabline'.setup {
  -- Defaults configuration options
  enable = true,
  options = {
    -- If lualine is installed tabline will use separators configured in lualine by default.
    -- These options can be used to override those settings.
    section_separators = {'', ''},
    -- section_separators = {'', ''},
    component_separators = {'', ''},
    max_bufferline_percent = nil, --66, -- set to nil by default, and it uses vim.o.columns * 2/3
    always_show_tabs = false, -- by default, this shows tabs only when there are more than one tab or if the first tab is named
  }
}

