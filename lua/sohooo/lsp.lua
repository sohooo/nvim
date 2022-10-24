-- LSP settings
-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- local opts = { noremap = true, silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- local servers = { 'solargraph', 'gopls', 'elixirls', 'sumneko_lua' }
local servers = { 'solargraph', 'gopls', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- rust
require'lspconfig'.rust_analyzer.setup{}

-- ruby/solargraph
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
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

-- elixir
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#elixirls
-- require'lspconfig'.elixirls.setup{
    -- cmd = { os.getenv("HOME") .. "/Code/elixir/ls/language_server.sh" };
-- }

-- lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


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

-- Change diagnostic symbols in the sign column (gutter)
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = {}
if Hifi() then
  signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
else
  -- signs = { Error = "Ⓔ ", Warn = "Ⓦ ", Hint = "Ⓗ ", Info = "Ⓘ " }
  -- ⚠ ☒ ★ ☆ ☼♡ ♢ ► ⊗ ⊖ ⊙ ⊛ ⊠ ⊹ ⋇ ⋗ ⋯ ◌ ●
  signs = { Error = "⊗", Warn = "⋇", Hint = "⋯", Info = "⊹" }
end
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- if not Hifi() then
--   vim.cmd([[
--   " Errors in Red
--   hi LspDiagnosticsDefaultError guifg=Red ctermfg=Red
--   " Warnings in Yellow
--   hi LspDiagnosticsDefaultWarning guifg=Yellow ctermfg=Yellow
--   " Info and Hints in White
--   hi LspDiagnosticsDefaultInformation guifg=White ctermfg=White
--   hi LspDiagnosticsDefaultHint guifg=White ctermfg=White
--
--     " hi link IndentBlanklineChar CursorLineSign
--     " hi link DiagnosticWarn WarningMsg
--     " hi link DiagnosticError WarningMsg
--     " hi link DiagnosticInfo WarningMsg
--     " hi link DiagnosticHint WarningMsg
--     " hi link DiagnosticUnderlineWarn WarningMsg
--     " hi link DiagnosticUnderlineError WarningMsg
--     " hi link DiagnosticUnderlineInfo WarningMsg
--     " hi link DiagnosticUnderlineHint WarningMsg
--     ]])
-- end
