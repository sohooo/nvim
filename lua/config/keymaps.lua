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

vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

for _, lhs in ipairs({
  "<leader>bb",
  "<leader>bd",
  "<leader>bo",
  "<leader>bi",
  "<leader>bD",
  "<leader>fn",
  "<leader>ft",
  "<leader>fT",
}) do
  pcall(vim.keymap.del, "n", lhs)
end

vim.keymap.set("n", "<leader>Bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>Bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>Bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>Bi", function()
  Snacks.bufdelete.invisible()
end, { desc = "Delete Invisible Buffers" })
vim.keymap.set("n", "<leader>BD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
vim.keymap.set("n", "<leader>q", function()
  Snacks.bufdelete()
end, { desc = "Close Current Buffer" })

vim.keymap.set("n", "<leader>pfn", "<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set("n", "<leader>pft", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<leader>pfT", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
