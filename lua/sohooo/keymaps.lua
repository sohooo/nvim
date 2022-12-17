-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
local wk = require("which-key")
local telescope = require('telescope.builtin')
wk.setup {}

wk.register({
  -- insert mode
  ["kj"]    = { "<Esc>", "normal mode", mode = "i" },
  -- ["<C-l>"] = { "<C-x><C-l>", "line compl", mode = "i" },

  -- visual mode
  [">"] = { ">gv", "indent more", mode = "v" },
  ["<"] = { "<gv", "indent less", mode = "v" },

  -- switch buffers
  ["<tab>"]   = { ":bnext<cr>", "next buffer" },
  ["<S-tab>"] = { ":bprevious<cr>", "prev buffer" },

  -- window movement
  ["<C-h>"] = { "<cmd>wincmd h<cr>", "left window" },
  ["<C-j>"] = { "<cmd>wincmd j<cr>", "bottom window" },
  ["<C-k>"] = { "<cmd>wincmd k<cr>", "upper window" },
  ["<C-l>"] = { "<cmd>wincmd l<cr>", "right window" },

  -- misc stuff
  ["<space>l"] = { "<cmd>nohlsearch<cr>", "remove search hl" },
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
  ["K"]     = { vim.lsp.buf.hover, "hover impl" },
  ["<c-p>"] = { vim.diagnostic.goto_prev, "lsp prev" },
  ["<c-n>"] = { vim.diagnostic.goto_next, "lsp next" },
  -- ["<c-k>"] = { vim.lsp.buf.signature_help, "signature" },
  ["g"] = {
    name = "+lsp",
    -- D = { vim.lsp.buf.declaration, "Declaration" },
    d = { require('goto-preview').goto_preview_definition, "Definition" },
    D = { vim.lsp.buf.definition, "Definition" },
    i = { require('goto-preview').goto_preview_implementation, "Implementation" },
    I = { vim.lsp.buf.implementation, "Implementation" },
    r = { require('goto-preview').goto_preview_references, "References" },
    R = { vim.lsp.buf.references, "References" },
    h = { vim.lsp.buf.hover, "Hover Docs" },
    ["p"] = {
      name = "+preview",
      p = { require('goto-preview').close_all_win, "Close Previews" },
      d = { require('goto-preview').goto_preview_definition, "Definition" },
      i = { require('goto-preview').goto_preview_implementation, "Implementation" },
      r = { require('goto-preview').goto_preview_references, "References" },
    }
  },
  ["<leader>"] = {
    name = "+main",
    a = { "<Plug>(LiveEasyAlign)", "Live Align", mode = "x" },
    d = { "<cmd>NvimTreeToggle<cr>", "Directory Tree" },
    f = { telescope.find_files, "Find File" },
    -- f = { require('sohooo/telescope').project_files, "Find File" },
    b = { telescope.buffers, "Open Buffers" },
    s = { telescope.live_grep, "Live Grep" },
    u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
    q = { "<cmd>bdelete<cr>", "close buffer" },
    -- .copy_file_location(mode, add_line, add_column)
    -- mode = absolute | workdir
    L = { require("nvim-file-location").copy_file_location('workdir', false, false), "Copy Path" },
    t = {
      name = "+telescope",
      h = { telescope.help_tags, "Help Tags" },
      a = { telescope.tags, "Tags" },
      d = { telescope.lsp_workspace_diagnostics, "LSP Diag" },
      t = { "<cmd>TermExec cmd='!!'<cr>", "rerun Term Command" },
      e = { "<cmd>ToggleTerm direction=horizontal<cr>", "Toggle Terminal", mode = {'n', 't'} },
      -- e = { "<cmd>ToggleTerm size=40 direction=horizontal<cr>", "Toggle Terminal", mode = {'n', 't'} },
      -- e = { ':lua NTGlobal["terminal"]:toggle()<cr>', "Terminal" },  -- nvim-terminal
      -- e = { '<cmd>Ttoggle<cr>', "Toggle Terminal" },  -- nvim-terminal
      o = { "<cmd>TodoTelescope<cr>", "Show Todos" },
      r = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
      s = {
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
            sorting_strategy = "ascending",
          })
        end,
        "Goto Symbol",
      },
    },
    c = {
      name = "+actions",
      a = { vim.lsp.buf.code_action, "Code Action" },
      -- a = { vim.lsp.buf.range_code_action, "Range Code Action", mode = "v" },
      r = { vim.lsp.buf.rename, "Rename" },
      s = { vim.lsp.buf.format, "Reformat File" },
    },
    g = {
      name = "+git",
      g = { "<cmd>Neogit<CR>", "NeoGit" },
      c = { telescope.git_commits, "commits" },
      b = { telescope.git_branches, "branches" },
      s = { telescope.git_status, "status" },
      h = { name = "+hunk" },
    },
    h = {
      name = "+help",
      a = { telescope.autocommands, "Auto Commands" },
      c = { telescope.commands, "Commands" },
      f = { telescope.filetypes, "File Types" },
      h = { telescope.help_tags, "Help Pages" },
      k = { telescope.keymaps, "Key Maps" },
      m = { telescope.man_pages, "Man Pages" },
      o = { telescope.vim_options, "Options" },
      s = { telescope.highlights, "Search Highlight Groups" },
      t = { telescope.builtin, "Telescope" },
      p = {
        name = "+packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        p = { "<cmd>PackerSync<cr>", "Sync" },
        s = { "<cmd>PackerStatus<cr>", "Status" },
      },
    },
    r = { -- TODO: happy with that?
      name = "+run/test",
      n = { "<cmd>TestNearest<cr>", "TestNearest" },
      f = { "<cmd>TestFile<cr>", "TestFile" },
      l = { "<cmd>TestLast<cr>", "TestLast" },
      r = { "<cmd>TestLast<cr>", "TestLast" },
      s = { "<cmd>TestSuite<cr>", "TestSuite" },
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


