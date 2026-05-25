return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>", group = "local" },
          { "<leader>c", group = "code" },
          { "<leader>g", group = "git" },
          { "<leader>t", group = "tools" },
          { "<leader>u", desc = "Undo Tree" },
          { "<leader>q", desc = "Close Buffer" },
          { "<leader>cw", desc = "Trim Trailing Whitespace" },
          { "ga", desc = "Align" },
          { "gA", desc = "Align with Preview" },
          { "gS", desc = "Toggle Split Join" },
          { "gs", group = "surround" },
          { "gsa", desc = "Add Surrounding" },
          { "gsd", desc = "Delete Surrounding" },
          { "gsr", desc = "Replace Surrounding" },
          { "gsh", desc = "Highlight Surrounding" },
          { "gsf", desc = "Find Surrounding Right" },
          { "gsF", desc = "Find Surrounding Left" },
          { "gsn", desc = "Update Surrounding Search Lines" },
        },
        {
          mode = "n",
          { "m", group = "more" },
          { "mf", desc = "Reveal File In Tree" },
        },
      },
    },
  },
}
