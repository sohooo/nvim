-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function clear_search()
  vim.cmd.nohlsearch()
end

for _, mode in ipairs({ "n", "i", "v", "x" }) do
  for _, lhs in ipairs({ "<A-j>", "<A-k>", "<M-j>", "<M-k>" }) do
    pcall(vim.keymap.del, mode, lhs)
  end
end

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
vim.keymap.set("n", "<BS>", clear_search, { desc = "Clear Search Highlight" })
vim.keymap.set("n", "<Del>", clear_search, { desc = "Clear Search Highlight" })
vim.keymap.set("n", "<kDel>", clear_search, { desc = "Clear Search Highlight" })
vim.keymap.set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP Health" })

vim.keymap.set("n", "<leader>aa", function()
  require("config.crush").open()
end, { desc = "Crush" })
vim.keymap.set("n", "<leader>aA", function()
  require("config.crush").continue()
end, { desc = "Crush Continue" })
vim.keymap.set("n", "<leader>af", function()
  require("config.crush").ask_file()
end, { desc = "Crush Current File" })
vim.keymap.set("n", "<leader>aF", function()
  require("config.crush").continue_file()
end, { desc = "Crush Current File Continue" })
vim.keymap.set("x", "<leader>as", function()
  require("config.crush").ask_selection()
end, { desc = "Crush Selection" })
vim.keymap.set("x", "<leader>aS", function()
  require("config.crush").continue_selection()
end, { desc = "Crush Selection Continue" })
vim.keymap.set("n", "<leader>al", function()
  require("config.crush").logs()
end, { desc = "Crush Logs" })
vim.keymap.set("n", "<leader>am", function()
  require("config.crush").models()
end, { desc = "Crush Models" })

for _, lhs in ipairs({
  "<leader>bb",
  "<leader>bd",
  "<leader>bo",
  "<leader>bi",
  "<leader>bD",
  "<leader>dph",
  "<leader>dpp",
  "<leader>dps",
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

vim.keymap.set("n", "<leader>tpp", function()
  Snacks.toggle.profiler():toggle()
end, { desc = "Toggle Profiler" })
vim.keymap.set("n", "<leader>tph", function()
  Snacks.toggle.profiler_highlights():toggle()
end, { desc = "Toggle Profiler Highlights" })
vim.keymap.set("n", "<leader>tps", function()
  Snacks.profiler.scratch()
end, { desc = "Profiler Scratch Buffer" })
