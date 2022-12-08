local lsp = require('lsp-zero')
local lspkind = require('lspkind')
local lspkind_mode = 'symbol_text'
local signs = { error = " ", warn = " ", hint = " ", info = " " }

-- lo-fi mode without nerdfont
if not Hifi() then
  lspkind_mode = 'text'
  signs = { error = "⊗", warn = "⋇", hint = "⋯", info = "⊹" }
end

-- lsp.preset('recommended')
lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = signs,
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

lsp.setup_nvim_cmp({
  formatting = {
    format = lspkind.cmp_format({
      mode = lspkind_mode, -- show only symbol annotations
      -- mode = 'symbol', -- show only symbol annotations
      maxwidth = 20, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function (entry, vim_item)
      --   ...
      --   return vim_item
      -- end
    }),
  },
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  })
})

-- available lsp servers:
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
lsp.ensure_installed({
  -- 'crystalline', -- Darwin_arm64 not supported
  -- 'erb-lint',
  -- 'puppet-editor-services',
  'rust_analyzer',
  -- 'shellcheck',
  'solargraph',
  'sumneko_lua',
  -- 'yamllint',
})

local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.nvim_workspace()
lsp.setup()

-- Initialize rust_analyzer with rust-tools
require('rust-tools').setup({ server = rust_lsp })

-- display inline warning/error messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  --virtual_text = false,
  virtual_text = {
    prefix = '⋇', -- Could be '●', '▎', 'x', ■
    spacing = 4,
    severity_limit = 'Warning',
  },
  underline = false,
  signs = true, -- signs customized below
  update_in_insert = true,
}
)
