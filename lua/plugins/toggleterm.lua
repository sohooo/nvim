local lazygit

local function lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal

  lazygit = lazygit
    or Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = term.bufnr, silent = true })
      end,
      on_close = function()
        vim.cmd("startinsert!")
      end,
    })

  lazygit:toggle()
end

return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>te", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal", mode = { "n", "t" } },
      { "<leader>tt", "<cmd>TermExec cmd='!!'<cr>", desc = "Rerun Terminal Command" },
      { "<leader>tg", lazygit_toggle, desc = "LazyGit Terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "single",
        width = 40,
        height = 15,
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.cmd([[
        function! ToggleTermStrategy(cmd) abort
          call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
        endfunction

        let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
      ]])
    end,
  },
}
