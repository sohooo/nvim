return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
      { "<leader>fe", false },
      { "<leader>fE", false },
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
      {
        "<leader>pfe",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>pfE",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
    },
    opts = {
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["<BS>"] = "clear_search",
                  ["<c-s>"] = "edit_split",
                  ["<c-v>"] = "edit_vsplit",
                  ["<Del>"] = "clear_search",
                  ["<kDel>"] = "clear_search",
                  ["i"] = "edit_split",
                  ["o"] = "confirm",
                  ["s"] = "edit_vsplit",
                },
              },
            },
            actions = {
              clear_search = function()
                vim.cmd.nohlsearch()
              end,
            },
          },
        },
      },
    },
  },
}
