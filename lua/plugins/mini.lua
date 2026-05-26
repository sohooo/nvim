return {
  { import = "lazyvim.plugins.extras.coding.mini-comment" },
  { import = "lazyvim.plugins.extras.coding.mini-snippets" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },

  {
    "nvim-mini/mini.align",
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align" },
      { "gA", mode = { "n", "x" }, desc = "Align with Preview" },
    },
    opts = {},
  },

  {
    "nvim-mini/mini.splitjoin",
    keys = {
      { "gS", desc = "Toggle Split Join" },
    },
    opts = {},
  },

  {
    "nvim-mini/mini.jump",
    keys = { "f", "F", "t", "T" },
    opts = {},
  },

  {
    "nvim-mini/mini.trailspace",
    event = "VeryLazy",
    keys = {
      {
        "<leader>cw",
        function()
          require("mini.trailspace").trim()
        end,
        desc = "Trim Trailing Whitespace",
      },
    },
    opts = {},
  },
}
