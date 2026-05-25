-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>u", function()
  local ok = pcall(vim.cmd.packadd, "nvim.undotree")
  if not ok then
    vim.notify("Native undotree requires Neovim 0.12 or newer", vim.log.levels.WARN)
    return
  end

  require("undotree").open()
end, { desc = "Toggle Undo Tree" })
