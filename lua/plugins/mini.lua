local function hifi()
  return vim.env.NVIM_STYLE ~= "plain"
end

return {
  { import = "lazyvim.plugins.extras.coding.mini-comment" },
  { import = "lazyvim.plugins.extras.coding.mini-snippets" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  { import = "lazyvim.plugins.extras.ui.mini-indentscope" },

  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    opts = {
      use_icons = hifi(),
    },
  },

  {
    "nvim-mini/mini.tabline",
    event = "VeryLazy",
    opts = {
      show_icons = hifi(),
    },
  },

  {
    "nvim-mini/mini.bufremove",
    keys = {
      {
        "<leader>q",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Close Current Buffer",
      },
    },
    opts = {},
  },

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
    "nvim-mini/mini.cursorword",
    event = "VeryLazy",
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

  {
    "nvim-mini/mini.cmdline",
    event = "CmdlineEnter",
    opts = {},
  },
}
