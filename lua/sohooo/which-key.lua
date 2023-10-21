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
  ["<space>"] = {
    k = { require("ts-node-action").node_action, "Trigger Node Action" },
  },
  ["<leader>"] = {
    name = "+main",
    d = { vim.cmd.NvimTreeToggle, "Directory Tree" },
    f = { telescope.find_files, "telescope find file" },
    l = { telescope.resume, "telescope last search" },
    -- l = { function()
    --   telescope.resume(require('telescope.themes').get_ivy({}))
    -- end, "telescope last search" },
    g = { _lazygit_toggle, "lazygit term" },
    b = { telescope.buffers, "telescope open buffers" },
    s = { telescope.live_grep, "telescope live grep" },
    u = { require('undotree').toggle, "toggle undo tree" },
    q = {
      function()
        require('bufdelete').bufdelete(0, true)
      end, "close current buffer" },
    t = {
      name = "+telescope",
      h = { telescope.help_tags, "telescope help tags" },
      c = { function()
        telescope.colorscheme({
          enable_preview = true
        })
      end, "telescope colorscheme"
      },
      d = { vim.cmd.TodoTelescope, "telescope show todos" },
      t = { "<cmd>TermExec cmd='!!'<cr>", "rerun terminal command" },
      e = { "<cmd>ToggleTerm direction=horizontal<cr>", "toggle terminal", mode = {'n', 't'} },
      -- e = { "<cmd>ToggleTerm size=40 direction=horizontal<cr>", "Toggle Terminal", mode = {'n', 't'} },
      -- e = { ':lua NTGlobal["terminal"]:toggle()<cr>', "Terminal" },  -- nvim-terminal
      -- e = { '<cmd>Ttoggle<cr>', "Toggle Terminal" },  -- nvim-terminal
      -- Treesitter Stuff
      s = {
        function()
          telescope.lsp_document_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
            sorting_strategy = "ascending",
          })
        end, "telescope goto symbol",
      },
    },
    c = {
      name = "+actions",
      a = { vim.lsp.buf.code_action, "lsp code action" },
      b = { vim.cmd.Block, "toggle code block visuals" },
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
    m = {
      name = "+misc",
      f = { vim.cmd.NvimTreeFindFile, "reveal file in tree" },
      m = { _mouse_toggle, "toggle mouse" },
    },
    r = {
      name = "+run/neotest",
      -- WIP functions, bindings, ...
      n = { function() require("neotest").run.run() end, "test nearest" },
      r = { function() require("neotest").run.run() end, "test nearest" },
      f = { function() require("neotest").run.run(vim.fn.expand("%")) end, "test file" },
      a = { function() require("neotest").run.run(vim.fn.getcwd()) end, "test all" },
      o = { function() require("neotest").output.open({ enter = true }) end, "output window" },
      p = { function() require("neotest").output_panel.toggle() end, "toggle output panel" },
      s = { function() require("neotest").summary.toggle() end, "toggle summary panel" },
      w = { function() require("neotest").watch.toggle(vim.fn.expand("%")) end, "watch file" }, -- LSP req.
    },
    v = {
      name = "+diffview",
      v = { vim.cmd.DiffviewOpen, "open diffview" },
      o = { vim.cmd.DiffviewOpen, "open diffview" },
      c = { vim.cmd.DiffviewClose, "close diffview" },
      h = { vim.cmd.DiffviewFileHistory, "history" },
      f = { "<cmd>DiffviewFileHistory %<cr>", "file history" },
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


