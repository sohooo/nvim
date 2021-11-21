-- LSP settings
-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
local servers = { 'solargraph' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- map buffer local keybindings when the language server attaches
-- ruby/solargraph
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#solargraph
require('lspconfig').solargraph.setup {
  on_attach = on_attach,
  settings = {
    solargraph = {
      autoformat = true,
      formatting = true,
      definitions = true,
      hover = true,
      logLevel = "warn",
      rename = true,
      symbols = true,
    }
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    --virtual_text = false,
    virtual_text = {
      prefix = '■', -- Could be '●', '▎', 'x'
      spacing = 4,
      severity_limit = 'Warning',
    },
    underline = false,
    signs = true, -- signs customized below
    update_in_insert = true,
  }
)

-- Change diagnostic symbols in the sign column (gutter)
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- TOOD: install?
-- require('lspkind').init({})

