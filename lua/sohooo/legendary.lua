-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
local status_ok, legendary = pcall(require, "legendary")
if not status_ok then
  print("legendary not working")
end

local toolbox = require("legendary.toolbox")

legendary.setup({
  which_key = {
    auto_register = true,
  },
  include_builtin = false,
  sort = {
    -- this takes precedence over other sort options
    frecency = {
      db_root = string.format("%s/legendary/", vim.fn.stdpath("data")),
      max_timestamps = 20,
    },
  },
})
