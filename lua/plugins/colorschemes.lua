return {
  { "arcticicestudio/nord-vim" },
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      opts.style = require("config.theme").current().tokyonight_style or opts.style
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      opts.flavour = require("config.theme").current().catppuccin_flavour or opts.flavour
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = function(_, opts)
      opts.theme = require("config.theme").current().kanagawa_theme or opts.theme
    end,
  },
}
