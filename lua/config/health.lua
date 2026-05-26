local M = {}

function M.apply()
  if Snacks and Snacks.input then
    Snacks.input.enable()
  end
  if Snacks and Snacks.picker then
    vim.ui.select = Snacks.picker.select
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = M.apply,
})

M.apply()

function M.check()
  vim.health.start("Local health policy")

  if Snacks and Snacks.input and vim.ui.input == Snacks.input.input then
    vim.health.ok("vim.ui.input uses Snacks.input")
  else
    vim.health.error("vim.ui.input is not using Snacks.input")
  end

  if Snacks and Snacks.picker and vim.ui.select == Snacks.picker.select then
    vim.health.ok("vim.ui.select uses Snacks.picker.select")
  else
    vim.health.error("vim.ui.select is not using Snacks.picker.select")
  end
end

return M
