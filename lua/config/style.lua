local M = {}

function M.icons_enabled()
  return vim.env.NVIM_STYLE ~= "plain"
end

return M
