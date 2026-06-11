return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bp", false },
      { "<leader>bP", false },
      { "<leader>br", false },
      { "<leader>bl", false },
      { "<leader>bj", false },
      { "<leader>Bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>BP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>Br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>Bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<leader>Bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    },
    opts = function(_, opts)
      opts.highlights = require("config.theme").bufferline_highlights() or opts.highlights
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = require("config.theme").lualine_theme()

      if opts.sections and opts.sections.lualine_c then
        opts.sections.lualine_c[4] = {
          function()
            local name = vim.api.nvim_buf_get_name(0)
            if name == "" then
              return "[No Name]"
            end
            return vim.fn.fnamemodify(name, ":p")
          end,
          cond = function()
            return vim.bo.buftype == ""
          end,
          padding = { left = 0, right = 1 },
        }
      end
    end,
  },
}
