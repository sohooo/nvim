--Map blankline
-- vim.g.indent_blankline_char = '|'
-- vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"
-- vim.g.indent_blankline_context_char = "+"
-- vim.g.indent_blankline_context_char_list = "-"

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  -- char = "#",
  show_current_context = true,
  show_current_context_start = true,
  -- show_end_of_line = true,
}

if not Hifi() then
  vim.cmd([[
    let g:indent_guides_auto_colors = 0
    " hi IndentGuidesOdd  ctermbg=black
    " hi IndentGuidesEven ctermbg=darkgrey
    " hi link IndentBlanklineChar Folded
    hi link IndentBlanklineChar CursorLineSign
    " IndentBlanklineChar
    " IndentBlanklineSpaceChar
    " IndentBlanklineSpaceCharBlankline
    " IndentBlanklineContextChar

    " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
    ]])
end

