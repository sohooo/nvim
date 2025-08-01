-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
-- Modes:
--   Normal       = "n"
--   Insert       = "i"
--   Visual       = "v"
--   Visual_Block = "x"
--   Terminal     = "t"
--   Command      = "c"
local wk = require("which-key")
local telescope = require('telescope.builtin')
wk.setup {}

-- separate binding to avoid duplicate index
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })
vim.keymap.set("n", "Q", "<nop>")

-- lazygit terminal
local Terminal  = require('toggleterm.terminal').Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    -- border = "double",
    height = function(term)
      return math.floor(vim.o.lines * 0.9)
    end,
    width = function(term)
      return math.floor(vim.o.columns * 0.9)
    end,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

function _mouse_toggle()
  if vim.o.mouse == '' then
    vim.o.mouse = 'a'
    print("mouse enabled")
  else
    vim.o.mouse = ''
    print("mouse disabled")
  end
end


wk.add({
  { "kj", "<Esc>", desc = "normal mode", mode = "i" },
  { ">", ">gv", desc = "indent more", mode = "v" },
  { "<", "<gv", desc = "indent less", mode = "v" },
  { "<tab>", function() vim.cmd.bnext() end, desc = "next buffer" },
  { "<S-tab>", function() vim.cmd.bprevious() end, desc = "prev buffer" },
  { "<C-h>", "<cmd>wincmd h<cr>", desc = "left window" },
  { "<C-j>", "<cmd>wincmd j<cr>", desc = "bottom window" },
  { "<C-k>", "<cmd>wincmd k<cr>", desc = "upper window" },
  { "<C-l>", "<cmd>wincmd l<cr>", desc = "right window" },
  { "<space>l", vim.cmd.nohlsearch, desc = "remove search hl" },
  { "j", "gj", desc = "ignore wrap j" },
  { "k", "gk", desc = "ignore wrap k" },
  { "J", "mzJ`z", desc = "join w/ fixed cursor" },
  { "n", "nzzzv", desc = "keep matches centered" },
  { "N", "Nzzzv", desc = "keep matches centered" },
  { "g;", "g;zz", desc = "keep jumps centered" },
  { "g,", "g,zz", desc = "keep jumps centered" },
  { "cn", "*``cgn", desc = "change word; next: ." },
  { "cN", "*``cgN", desc = "change word; next: ." },
  { "K", vim.lsp.buf.hover, desc = "lsp hover impl" },
  { "<c-p>", vim.diagnostic.goto_prev, desc = "lsp prev" },
  { "<c-n>", vim.diagnostic.goto_next, desc = "lsp next" },
  { "g", group = "+lsp" },
  { "gd", require('goto-preview').goto_preview_definition, desc = "preview definition" },
  { "gD", vim.lsp.buf.definition, desc = "goto definition" },
  { "gi", require('goto-preview').goto_preview_implementation, desc = "preview implementation" },
  { "gI", vim.lsp.buf.implementation, desc = "goto implementation" },
  { "gr", require('goto-preview').goto_preview_references, desc = "preview references" },
  { "gR", vim.lsp.buf.references, desc = "goto references" },
  { "gh", vim.lsp.buf.hover, desc = "goto hover docs" },
  { "gp", group = "+preview" },
  { "gpp", require('goto-preview').close_all_win, desc = "close previews" },
  { "gpd", require('goto-preview').goto_preview_definition, desc = "preview definition" },
  { "gpi", require('goto-preview').goto_preview_implementation, desc = "preview implementation" },
  { "gpr", require('goto-preview').goto_preview_references, desc = "preview references" },
  { "<space>k", require("ts-node-action").node_action, desc = "Trigger Node Action" },
  { "<leader>", group = "+main" },
  { "<leader>d", vim.cmd.NvimTreeToggle, desc = "Directory Tree" },
  { "<leader>f", telescope.find_files, desc = "telescope find file" },
  { "<leader>l", telescope.resume, desc = "telescope last search" },
  { "<leader>g", _lazygit_toggle, desc = "lazygit term" },
  { "<leader>b", telescope.buffers, desc = "telescope open buffers" },
  { "<leader>s", telescope.live_grep, desc = "telescope live grep" },
  { "<leader>u", require('undotree').toggle, desc = "toggle undo tree" },
  { "<leader>q", function() require('bufdelete').bufdelete(0, true) end, desc = "close current buffer" },
  { "<leader>t", group = "+telescope" },
  { "<leader>th", telescope.help_tags, desc = "telescope help tags" },
  { "<leader>tc", function() telescope.colorscheme({ enable_preview = true }) end, desc = "telescope colorscheme" },
  { "<leader>td", vim.cmd.TodoTelescope, desc = "telescope show todos" },
  { "<leader>tt", "<cmd>TermExec cmd='!!'<cr>", desc = "rerun terminal command" },
  { "<leader>te", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "toggle terminal", mode = { 'n', 't' } },
  {
    "<leader>ts",
    function()
      telescope.lsp_document_symbols({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
        sorting_strategy = "ascending",
      })
    end,
    desc = "telescope goto symbol",
  },
  { "<leader>c", group = "+actions" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "lsp code action" },
  { "<leader>cb", vim.cmd.Block, desc = "toggle code block visuals" },
  { "<leader>cr", vim.lsp.buf.rename, desc = "lsp rename" },
  { "<leader>cj", vim.cmd.TSJToggle, desc = "toggle split/join" },
  { "<leader>cf", vim.lsp.buf.format, desc = "lsp reformat file" },
  { "<leader>cv", require("refactoring").select_refactor, desc = "refactor selection", mode = "v" },
  { "<leader>ct", group = "+treesitter" },
  { "<leader>ctp", vim.cmd.TSPlaygroundToggle, desc = "treesitter playground" },
  { "<leader>cth", vim.cmd.TSHighlightCapturesUnderCursor, desc = "treesitter highlight element" },
  { "<leader>h", group = "+help" },
  { "<leader>ha", telescope.autocommands, desc = "telescope autocommands" },
  { "<leader>hc", telescope.commands, desc = "telescope commands" },
  { "<leader>hf", telescope.filetypes, desc = "telescope filetypes" },
  { "<leader>hh", telescope.help_tags, desc = "telescope help tags" },
  { "<leader>hk", telescope.keymaps, desc = "telescope keymaps" },
  { "<leader>hm", telescope.man_pages, desc = "telescope man pages" },
  { "<leader>ho", telescope.vim_options, desc = "telescope options" },
  { "<leader>hs", telescope.highlights, desc = "telescpe highlights" },
  { "<leader>ht", telescope.builtin, desc = "Telescope" },
  { "<leader>m", group = "+misc" },
  { "<leader>mf", vim.cmd.NvimTreeFindFile, desc = "reveal file in tree" },
  { "<leader>mm", _mouse_toggle, desc = "toggle mouse" },
  { "<leader>r", group = "+run/neotest" },
  { "<leader>rn", function() require("neotest").run.run() end, desc = "test nearest" },
  { "<leader>rr", function() require("neotest").run.run() end, desc = "test nearest" },
  { "<leader>rf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "test file" },
  { "<leader>ra", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "test all" },
  { "<leader>ro", function() require("neotest").output.open({ enter = true }) end, desc = "output window" },
  { "<leader>rp", function() require("neotest").output_panel.toggle() end, desc = "toggle output panel" },
  { "<leader>rs", function() require("neotest").summary.toggle() end, desc = "toggle summary panel" },
  { "<leader>rw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "watch file" },
  { "<leader>v", group = "+diffview" },
  { "<leader>vv", vim.cmd.DiffviewOpen, desc = "open diffview" },
  { "<leader>vo", vim.cmd.DiffviewOpen, desc = "open diffview" },
  { "<leader>vc", vim.cmd.DiffviewClose, desc = "close diffview" },
  { "<leader>vh", vim.cmd.DiffviewFileHistory, desc = "history" },
  { "<leader>vf", "<cmd>DiffviewFileHistory %<cr>", desc = "file history" },
  { "<leader>w", group = "+workspace" },
  { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" },
  { "<leader>wl", vim.lsp.buf.list_workspace_folders, desc = "List Folders" },
  { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" },
})

-- filetype specific keybinds
-- vim.cmd('autocmd FileType * lua setFiletypeKeybinds()')
-- function setFiletypeKeybinds()
--   local type = vim.api.nvim_buf_get_option(0, "filetype")
--   local opts = { prefix = '<leader>', buffer = 0 }
--
--   if type == 'rust' then
--     local rt = require("rust-tools")
--     wk.register({
--       c = {
--         a = { rt.code_action_group.code_action_group },
--       },
--     }, opts)
--
--     -- elseif type == 'sh' then
--     --     wk.register({
--     --         ['W'] = {':w<CR>', 'test write'},
--     --         ['Q'] = {':q<CR>', 'test quit'},
--     --     }, opts)
--   end
-- end


