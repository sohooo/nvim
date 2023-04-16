-- setup based on: https://github.com/VonHeikemen/nvim-starter/blob/03-lsp/init.lua
---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
require('luasnip.loaders.from_vscode').lazy_load()

-- lspkind
local lspkind = require('lspkind')
local lspkind_mode = 'symbol_text'

-- lo-fi mode without nerdfont
if not Hifi() then
  lspkind_mode = 'text'
end


---
-- nvim-cmp (autocomplete)
---
-- vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

-- See :help cmp-config
cmp.setup({
  -- dont preselect first suggestion
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
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
  -- formatting = {
  --   fields = {'menu', 'abbr', 'kind'},
  --   format = function(entry, item)
  --     local menu_icon = {
  --       nvim_lsp = 'λ',
  --       luasnip = '⋗',
  --       buffer = 'Ω',
  --       path = '🖫',
  --     }
  --
  --     item.menu = menu_icon[entry.source.name]
  --     return item
  --   end,
  -- },
  -- See :help cmp-mapping
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),

    -- ['<C-e>'] = cmp.mapping.abort(),
    -- ['<C-y>'] = cmp.mapping.confirm({select = true}),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
    --
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   local col = vim.fn.col('.') - 1
    --
    --   if cmp.visible() then
    --     cmp.select_next_item(select_opts)
    --   elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    --     fallback()
    --   else
    --     cmp.complete()
    --   end
    -- end, {'i', 's'}),
    --
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item(select_opts)
    --   else
    --     fallback()
    --   end
    -- end, {'i', 's'}),
  },
})


---
-- Mason.nvim
---
-- See :help mason-settings
-- require('mason').setup({
--   ui = {border = 'rounded'}
-- })

-- See :help mason-lspconfig-settings
-- require('mason-lspconfig').setup({
--   ensure_installed = {
--     -- 'tsserver',
--     -- 'eslint',
--     -- 'html',
--     -- 'cssls'
--   }
-- })


---
-- LSP config
---
-- See :help lspconfig-global-defaults
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ' '})
sign({name = 'DiagnosticSignWarn', text = ' '})
sign({name = 'DiagnosticSignHint', text = ' '})
sign({name = 'DiagnosticSignInfo', text = ' '})

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = {
    prefix = '⋇', -- Could be '●', '▎', 'x', ■
    spacing = 4,
    severity_limit = 'Warning', -- FIXME: option missing; old-school config below
  },
  underline = false,
  signs = true, -- signs customized below
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    --virtual_text = false,
    virtual_text = {
      prefix = '⋇', -- Could be '●', '▎', 'x', ■
      spacing = 4,
      severity_limit = 'Warning',
    },
    -- underline = false,
    -- signs = true,
    -- update_in_insert = true,
  }
)

---
-- LSP Keybindings
---
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = group,
--   desc = 'LSP actions',
--   callback = function()
--     local bufmap = function(mode, lhs, rhs)
--       local opts = {buffer = true}
--       vim.keymap.set(mode, lhs, rhs, opts)
--     end
--
--     -- You can search each function in the help page.
--     -- For example :help vim.lsp.buf.hover()
--
--     bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
--     bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
--     bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
--     bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
--     bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
--     bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
--     bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
--     bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
--     bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
--     bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
--     bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
--     bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
--
--     bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--     bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--
--     -- if using Neovim v0.8 uncomment this
--     -- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
--   end
-- })


---
-- LSP servers
---
-- See :help mason-lspconfig-dynamic-server-setup
-- require('mason-lspconfig').setup_handlers({
--   function(server)
--     -- See :help lspconfig-setup
--     lspconfig[server].setup({})
--   end,
--   ['tsserver'] = function()
--     lspconfig.tsserver.setup({
--       settings = {
--         completions = {
--           completeFunctionCalls = true
--         }
--       }
--     })
--   end
-- })


-- Prevent multiple instance of lsp servers
-- if file is sourced again
if vim.g.lsp_setup_ready == nil then
  vim.g.lsp_setup_ready = true

  -- See :help lspconfig-setup
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  -- puppet setup: https://github.com/puppetlabs/puppet-editor-services
  require'lspconfig'.gopls.setup{} -- gopls
  require'lspconfig'.puppet.setup{} -- puppet-languageserver
  require'lspconfig'.pylsp.setup{} -- pylsp
  require'lspconfig'.rust_analyzer.setup{} -- rust-analyzer
  require'lspconfig'.solargraph.setup{} --solargraph

  -- require'lspconfig'.lua_ls.setup{} -- lua-language-server
  require'lspconfig'.lua_ls.setup {
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

  -- Initialize rust_analyzer with rust-tools
  require('rust-tools').setup({ server = rust_lsp })

end







--
-- -- LSP settings
-- -- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
-- local nvim_lsp = require 'lspconfig'
-- local on_attach = function(_, bufnr)
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- local opts = { noremap = true, silent = true }
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- end
--
-- -- nvim-cmp supports additional completion capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- -- Enable the following language servers
-- -- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- -- local servers = { 'solargraph', 'gopls', 'elixirls', 'sumneko_lua' }
-- local servers = { 'solargraph', 'gopls', 'sumneko_lua' }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end
--
--
-- -- rust
-- require'lspconfig'.rust_analyzer.setup{}
--
-- -- ruby/solargraph
-- -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
-- require('lspconfig').solargraph.setup {
--   on_attach = on_attach,
--   settings = {
--     solargraph = {
--       autoformat = true,
--       formatting = true,
--       definitions = true,
--       hover = true,
--       logLevel = "warn",
--       rename = true,
--       symbols = true,
--     }
--   }
-- }
--
-- -- elixir
-- -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#elixirls
-- -- require'lspconfig'.elixirls.setup{
--     -- cmd = { os.getenv("HOME") .. "/Code/elixir/ls/language_server.sh" };
-- -- }
--
-- -- lua
-- -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
-- require'lspconfig'.sumneko_lua.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
--
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     --virtual_text = false,
--     virtual_text = {
--       prefix = '⋇', -- Could be '●', '▎', 'x', ■
--       spacing = 4,
--       severity_limit = 'Warning',
--     },
--     underline = false,
--     signs = true, -- signs customized below
--     update_in_insert = true,
--   }
-- )
--
-- -- Change diagnostic symbols in the sign column (gutter)
-- -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
-- local signs = {}
-- if Hifi() then
--   signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- else
--   -- signs = { Error = "Ⓔ ", Warn = "Ⓦ ", Hint = "Ⓗ ", Info = "Ⓘ " }
--   -- ⚠ ☒ ★ ☆ ☼♡ ♢ ► ⊗ ⊖ ⊙ ⊛ ⊠ ⊹ ⋇ ⋗ ⋯ ◌ ●
--   signs = { Error = "⊗", Warn = "⋇", Hint = "⋯", Info = "⊹" }
-- end
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end
--
-- -- if not Hifi() then
-- --   vim.cmd([[
-- --   " Errors in Red
-- --   hi LspDiagnosticsDefaultError guifg=Red ctermfg=Red
-- --   " Warnings in Yellow
-- --   hi LspDiagnosticsDefaultWarning guifg=Yellow ctermfg=Yellow
-- --   " Info and Hints in White
-- --   hi LspDiagnosticsDefaultInformation guifg=White ctermfg=White
-- --   hi LspDiagnosticsDefaultHint guifg=White ctermfg=White
-- --
-- --     " hi link IndentBlanklineChar CursorLineSign
-- --     " hi link DiagnosticWarn WarningMsg
-- --     " hi link DiagnosticError WarningMsg
-- --     " hi link DiagnosticInfo WarningMsg
-- --     " hi link DiagnosticHint WarningMsg
-- --     " hi link DiagnosticUnderlineWarn WarningMsg
-- --     " hi link DiagnosticUnderlineError WarningMsg
-- --     " hi link DiagnosticUnderlineInfo WarningMsg
-- --     " hi link DiagnosticUnderlineHint WarningMsg
-- --     ]])
-- -- end
