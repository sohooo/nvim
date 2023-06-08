vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- format on save
-- FIXME: check for lsp server
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   buffer = buffer,
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end,
-- })

-- reload config file on change
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'bufcheck',
  pattern = vim.env.MYVIMRC,
  command = 'silent source %',
})

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'bufcheck',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
})

-- start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'bufcheck',
  pattern = '*',
  command = 'startinsert | set winfixheight',
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
  group = 'bufcheck',
  pattern = { 'gitcommit', 'gitrebase' },
  command = 'startinsert | 1',
})

-- Strip trailing whitespaces on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = '%s/\\s\\+$//e' })
