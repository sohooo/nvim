-- Treesitter configuration
-- WARN: this is based on Treesitter 'master', which is deprecated
--
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  ensure_installed = 'all',
  -- ensure_installed = { -- one of "all", "maintained" (parsers with maintainers, deprecated!), or a list of languages
  --   "bash",
  --   "css",
  --   "go",
  --   "html",
  --   "json",
  --   "lua",
  --   "php",
  --   "python",
  --   "ruby",
  --   "rust",
  --   "toml",
  --   "yaml",
  -- },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  autotag = {
    enable = true,
  },
  endwise = { -- 'RRethy/nvim-treesitter-endwise'
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<cr>',
      node_incremental = '<cr>',
      scope_incremental = false,
      node_decremental = '<bs>',
    },
  },
  indent = {
    enable = true,
    disable = { 'puppet' },
  },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      ['<c-k>'] = 'textsubjects-container-outer',
      ['<c-j>'] = 'textsubjects-container-inner',
    },
  },
}

-- Users of packer.nvim have reported that when using treesitter for folds,
-- they sometimes receive an error "No folds found", or that treesitter
-- highlighting does not apply. A workaround for this is to set the folding
-- options in an autocmd:
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })
---ENDWORKAROUND
