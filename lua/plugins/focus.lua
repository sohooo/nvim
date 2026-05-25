return {
  {
    "beauwilliams/focus.nvim",
    event = "WinEnter",
    opts = {
      bufnew = false,
      number = false,
      signcolumn = false,
    },
    config = function(_, opts)
      require("focus").setup(opts)

      local ignore_filetypes = { "neo-tree", "snacks_picker_list" }
      local ignore_buftypes = { "nofile", "prompt", "popup" }
      local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

      vim.api.nvim_create_autocmd("WinEnter", {
        group = augroup,
        callback = function()
          vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        end,
        desc = "Disable focus autoresize for BufType",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function()
          vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
        end,
        desc = "Disable focus autoresize for FileType",
      })
    end,
  },
}
