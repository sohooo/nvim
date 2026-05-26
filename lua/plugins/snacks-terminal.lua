return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>te",
        function()
          Snacks.terminal(nil, {
            cwd = LazyVim.root(),
            win = { position = "bottom", height = 15 },
          })
        end,
        desc = "Toggle Terminal",
        mode = { "n", "t" },
      },
      {
        "<leader>tt",
        function()
          Snacks.terminal(nil, {
            cwd = LazyVim.root(),
            win = { position = "bottom", height = 15 },
          })
        end,
        desc = "Toggle Terminal",
      },
      {
        "<leader>tg",
        function()
          Snacks.terminal("lazygit", {
            cwd = LazyVim.root(),
            win = {
              position = "float",
              height = 0.9,
              width = 0.9,
              border = "single",
            },
          })
        end,
        desc = "LazyGit Terminal",
      },
    },
  },
}
