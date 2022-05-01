-- vim-test
-- https://github.com/vim-test/vim-test#ruby
vim.cmd([[
  "let test#ruby#bundle_exec = 0
  "let test#ruby#use_binstubs = 0

  "let g:dispatch_compilers = {}
  "let g:dispatch_compilers['./vendor/bin/'] = ''
  "let g:dispatch_compilers['phpunit'] = 'phpunit2'
]])

-- FIXME: lua logic for local rspec binstubs
-- if rspec file in project root, use it
vim.g['test#strategy'] = 'toggleterm'


-- fix common typos
vim.cmd(':command! WQ wq')
vim.cmd(':command! Wq wq')
vim.cmd(':command! Wqa wqa')
vim.cmd(':command! W w')
vim.cmd(':command! Q q')
vim.cmd(':command! Qa qa')

-- exit terminal
vim.cmd([[
  tnoremap <Esc><Esc> <C-\><C-n>
]])

-- vim-go
vim.cmd([[
  let g:go_imports_mode='gopls'
  let g:go_imports_autosave=1
  let g:go_auto_type_info = 1
  let g:go_fmt_autosave = 1
  let g:go_fmt_options = { 'gofmt': '-s' }
  let g:go_doc_keywordprg_enabled = 0
  " let g:go_def_mapping_enabled = 0
]])

-- }}}

