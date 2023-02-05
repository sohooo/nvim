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
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "Q", "<nop>")

wk.register({
  -- insert mode
  ["kj"]    = { "<Esc>", "normal mode", mode = "i" },
  -- ["<C-l>"] = { "<C-x><C-l>", "line compl", mode = "i" },

  -- visual mode
  [">"] = { ">gv", "indent more", mode = "v" },
  ["<"] = { "<gv", "indent less", mode = "v" },

  -- switch buffers
  ["<tab>"]   = { vim.cmd.bnext, "next buffer" },
  ["<S-tab>"] = { vim.cmd.bprevious, "prev buffer" },

  -- window movement
  ["<C-h>"] = { "<cmd>wincmd h<cr>", "left window" },
  ["<C-j>"] = { "<cmd>wincmd j<cr>", "bottom window" },
  ["<C-k>"] = { "<cmd>wincmd k<cr>", "upper window" },
  ["<C-l>"] = { "<cmd>wincmd l<cr>", "right window" },

  -- misc stuff
  ["<space>l"] = { vim.cmd.nohlsearch, "remove search hl" },
  ["j"] = { "gj", "ignore wrap j" },
  ["k"] = { "gk", "ignore wrap k" },
  ["J"] = { "mzJ`z", "join w/ fixed cursor" },
  ["n"] = { "nzzzv", "keep matches centered" },
  ["N"] = { "Nzzzv", "keep matches centered" },
  ["g;"] = { "g;zz", "keep jumps centered" },
  ["g,"] = { "g,zz", "keep jumps centered" },
  ["cn"] = { "*``cgn", "change word; next: ." },
  ["cN"] = { "*``cgN", "change word; next: ." },

  -- lsp stuff
  ["K"]     = { vim.lsp.buf.hover, "lsp hover impl" },
  ["<c-p>"] = { vim.diagnostic.goto_prev, "lsp prev" },
  ["<c-n>"] = { vim.diagnostic.goto_next, "lsp next" },
  -- ["<c-k>"] = { vim.lsp.buf.signature_help, "signature" },
  ["g"] = {
    name = "+lsp",
    -- D = { vim.lsp.buf.declaration, "Declaration" },
    d = { require('goto-preview').goto_preview_definition, "preview definition" },
    D = { vim.lsp.buf.definition, "goto definition" },
    i = { require('goto-preview').goto_preview_implementation, "preview implementation" },
    I = { vim.lsp.buf.implementation, "goto implementation" },
    r = { require('goto-preview').goto_preview_references, "preview references" },
    R = { vim.lsp.buf.references, "goto references" },
    h = { vim.lsp.buf.hover, "goto hover docs" },
    ["p"] = {
      name = "+preview",
      p = { require('goto-preview').close_all_win, "close previews" },
      d = { require('goto-preview').goto_preview_definition, "preview definition" },
      i = { require('goto-preview').goto_preview_implementation, "preview implementation" },
      r = { require('goto-preview').goto_preview_references, "preview references" },
    }
  },
  ["<leader>"] = {
    name = "+main",
    ["<space>"] = { vim.cmd.Legendary, "legendary command bar" },
    a = { "<Plug>(LiveEasyAlign)", "Live Align", mode = "x" },
    d = { vim.cmd.NvimTreeToggle, "Directory Tree" },
    f = { telescope.find_files, "telescope find file" },
    -- f = { require('sohooo/telescope').project_files, "Find File" },
    b = { telescope.buffers, "telescope open buffers" },
    s = { telescope.live_grep, "telescope live grep" },
    u = { vim.cmd.UndoTreeToggle, "undo tree" },
    q = { vim.cmd.bdelete, "close buffer" },
    -- q = { "<cmd>bdelete<cr>", "close buffer" },
    t = {
      name = "+telescope",
      h = { telescope.help_tags, "telescope help tags" },
      a = { telescope.tags, "telescope tags" },
      d = { telescope.lsp_workspace_diagnostics, "telescope lsp diag" },
      t = { "<cmd>TermExec cmd='!!'<cr>", "rerun terminal command" },
      e = { "<cmd>ToggleTerm direction=horizontal<cr>", "toggle terminal", mode = {'n', 't'} },
      -- e = { "<cmd>ToggleTerm size=40 direction=horizontal<cr>", "Toggle Terminal", mode = {'n', 't'} },
      -- e = { ':lua NTGlobal["terminal"]:toggle()<cr>', "Terminal" },  -- nvim-terminal
      -- e = { '<cmd>Ttoggle<cr>', "Toggle Terminal" },  -- nvim-terminal
      o = { vim.cmd.TodoTelescope, "telescope show todos" },
      r = { telescope.lsp_references, "telescope lsp references" },
      R = { vim.cmd.TroubleToggle, "toggle trouble" },
      -- Treesitter Stuff
      s = {
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
            sorting_strategy = "ascending",
          })
        end,
        "telescope goto symbol",
      },
    },
    c = {
      name = "+actions",
      a = { vim.lsp.buf.code_action, "lsp code action" },
      -- a = { vim.lsp.buf.range_code_action, "Range Code Action", mode = "v" },
      -- s = symbols outline: init.lua
      r = { vim.lsp.buf.rename, "lsp rename" },
      j = { vim.cmd.TSJToggle, "toggle split/join"},
      f = { vim.lsp.buf.format, "lsp reformat file" },
      v = { require("refactoring").select_refactor, "refactor selection", mode = "v" },
      t = {
        name = "+treesitter",
        p = { vim.cmd.TSPlaygroundToggle, "treesitter playground" },
        h = { vim.cmd.TSHighlightCapturesUnderCursor, "treesitter highlight element" },
      },
    },
    g = {
      name = "+git",
      g = { "<cmd>Neogit<CR>", "neogit" },
      c = { telescope.git_commits, "neogit commits" },
      b = { telescope.git_branches, "neogit branches" },
      s = { telescope.git_status, "neogit status" },
      h = { name = "+hunk" },
    },
    h = {
      name = "+help",
      a = { telescope.autocommands, "telescope autocommands" },
      c = { telescope.commands, "telescope commands" },
      f = { telescope.filetypes, "telescope filetypes" },
      h = { telescope.help_tags, "telescope help tags" },
      k = { telescope.keymaps, "telescope keymaps" },
      m = { telescope.man_pages, "telescope man pages" },
      o = { telescope.vim_options, "telescope options" },
      s = { telescope.highlights, "telescpe highlights" },
      t = { telescope.builtin, "Telescope" },
    },
    r = { -- TODO: happy with that?
      name = "+run/test",
      n = { "<cmd>TestNearest<cr>", "test nearest" },
      f = { "<cmd>TestFile<cr>", "test file" },
      l = { "<cmd>TestLast<cr>", "test last" },
      r = { "<cmd>TestLast<cr>", "test last" },
      s = { "<cmd>TestSuite<cr>", "test suite" },
    },
    w = {
      name = "+workspace",
      a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
      l = { vim.lsp.buf.list_workspace_folders, "List Folders" },
      r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
    },
      -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  },
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


