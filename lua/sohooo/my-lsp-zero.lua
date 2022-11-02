local lsp = require('lsp-zero')
local lspkind = require('lspkind')
local lspkind_mode = 'symbol_text'
if not Hifi() then lspkind_mode = 'text' end

lsp.preset('recommended')
lsp.setup_nvim_cmp({
  formatting = {
    format = lspkind.cmp_format({
      mode = lspkind_mode, -- show only symbol annotations
      -- mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function (entry, vim_item)
      --   ...
      --   return vim_item
      -- end
    }),
  }
})

-- available lsp servers:
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
lsp.ensure_installed({
  'crystalline', -- Darwin_arm64 not supported
  'puppet',
  'rust_analyzer',
  'solargraph',
  'sumneko_lua',
})

local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.nvim_workspace()
lsp.setup()

-- Initialize rust_analyzer with rust-tools
require('rust-tools').setup({server = rust_lsp})

