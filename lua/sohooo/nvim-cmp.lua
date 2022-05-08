-- Setup nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format(),
    },

    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- for vsnip
      end,
    },

  -- mappings ------------------------------------------------------------
    mapping = cmp.mapping.preset.insert({
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    -- mapping = {
    --   -- hit 'K' again to enter docs popup; 'q' to quit it
    --   ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    --   ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    --   ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    --   ['<C-y>'] = cmp.config.disable, --`cmp.config.disable` to remove the default `<C-y>` mapping
    --   ['<C-e>'] = cmp.mapping({
    --     i = cmp.mapping.abort(),
    --     c = cmp.mapping.close(),
    --   }),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- -- tab completion
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif vim.fn["vsnip#available"](1) == 1 then
    --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    --   end
    -- end, { "i", "s" }),
    --
    -- ["<S-Tab>"] = cmp.mapping(function()
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    --     feedkey("<Plug>(vsnip-jump-prev)", "")
    --   end
    -- end, { "i", "s" }),
    -- },

    -- sources ------------------------------------------------------------
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['solargraph'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }


-- -- nvim-cmp setup
-- local cmp = require 'cmp'
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
--     ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--     ['<C-k>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-j>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = function(fallback)
--       if vim.fn.pumvisible() == 1 then
--         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
--       elseif luasnip.expand_or_jumpable() then
--         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
--       else
--         fallback()
--       end
--     end,
--     ['<S-Tab>'] = function(fallback)
--       if vim.fn.pumvisible() == 1 then
--         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
--       elseif luasnip.jumpable(-1) then
--         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
--       else
--         fallback()
--       end
--     end,
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = "path" },
--     { name = 'luasnip' },
--     { name = "buffer", keyword_length = 5 },
--   },
-- }
--
