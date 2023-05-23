require'lualine'.setup {
  options = {
    icons_enabled = Hifi(),
    theme = MyColors()['lualine'],  -- iceberg, moonlight | material-nvim | nord | aquarium | tokyonight
    -- theme = 'tokyonight',  -- iceberg, moonlight | material-nvim | nord | aquarium | tokyonight
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  -- https://github.com/nvim-lualine/lualine.nvim#general-component-options
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1, -- 0: Just the filename
                  -- 1: Relative path
                  -- 2: Absolute path
                  -- 3: Absolute path, with tilde as the home directory
                  -- 4: Filename and parent dir, with tilde as the home directory
      }
    },
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
  extensions = {
    'nvim-tree',
    'toggleterm',
  }
}

require'tabline'.setup {
  -- Defaults configuration options
  enable = true,
  options = {
    -- If lualine is installed tabline will use separators configured in lualine by default.
    -- These options can be used to override those settings.
    section_separators = {'', ''},
    component_separators = {'>', '<'},
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
    show_devicons = Hifi(), -- this shows devicons in buffer section
    show_bufnr = false, -- this appends [bufnr] to buffer section,
    show_filename_only = false, -- shows base filename only instead of relative path in filename
    modified_icon = "+ ", -- change the default modified icon
    modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
    show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
  }
}

