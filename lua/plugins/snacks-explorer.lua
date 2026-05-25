return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
      {
        "<leader>d",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Directory Tree",
      },
      {
        "mf",
        function()
          Snacks.explorer.reveal()
        end,
        desc = "Reveal File In Explorer",
      },
    },
    opts = {
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["o"] = "confirm",
                },
              },
            },
          },
        },
      },
    },
  },
}
