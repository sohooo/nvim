-- config docs:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
local null_ls = require("null-ls")

local wrap_builtin = function(builtin)
  local command = builtin._opts.command
  builtin.condition = function()
    return vim.fn.executable(command) > 0
  end
  return builtin
end

local sources = {
  wrap_builtin(null_ls.builtins.formatting.crystal_format),
  wrap_builtin(null_ls.builtins.diagnostics.erb_lint),
  wrap_builtin(null_ls.builtins.formatting.erb_lint),
  wrap_builtin(null_ls.builtins.formatting.gofmt),
  wrap_builtin(null_ls.builtins.formatting.goimports),
  wrap_builtin(null_ls.builtins.formatting.jq),
  wrap_builtin(null_ls.builtins.formatting.mix),
  wrap_builtin(null_ls.builtins.formatting.pg_format),
  wrap_builtin(null_ls.builtins.formatting.prettier),
  wrap_builtin(null_ls.builtins.diagnostics.puppet_lint),
  wrap_builtin(null_ls.builtins.formatting.puppet_lint),
  wrap_builtin(null_ls.builtins.formatting.rubocop).with({
    prefer_local = true,
  }),
  wrap_builtin(null_ls.builtins.diagnostics.rubocop).with({
    prefer_local = true,
  }),
  wrap_builtin(null_ls.builtins.code_actions.shellcheck),
  wrap_builtin(null_ls.builtins.diagnostics.shellcheck),
}

-- -- register any number of sources simultaneously
-- local sources = {
--   null_ls.builtins.formatting.crystal_format.with({
--     condition = function() return vim.fn.executable("crystal_format") > 0 end,
--   }),
--   null_ls.builtins.diagnostics.erb_lint.with({
--     condition = function() return vim.fn.executable("erblint") > 0 end,
--   }),
--   null_ls.builtins.formatting.erb_lint.with({
--     condition = function() return vim.fn.executable("erblint") > 0 end,
--   }),
--   null_ls.builtins.formatting.gofmt.with({
--     condition = function() return vim.fn.executable("gofmt") > 0 end,
--   }),
--   null_ls.builtins.formatting.goimports.with({
--     condition = function() return vim.fn.executable("goimports") > 0 end,
--   }),
--   null_ls.builtins.formatting.jq.with({
--     condition = function() return vim.fn.executable("jq") > 0 end,
--   }),
--   null_ls.builtins.formatting.mix.with({
--     condition = function() return vim.fn.executable("mix") > 0 end,
--   }),
--   null_ls.builtins.formatting.pg_format.with({
--     condition = function() return vim.fn.executable("pg_format") > 0 end,
--   }),
--   null_ls.builtins.formatting.prettier.with({
--     condition = function() return vim.fn.executable("prettier") > 0 end,
--   }),
--   null_ls.builtins.diagnostics.puppet_lint.with({
--     condition = function() return vim.fn.executable("puppet-lint") > 0 end,
--   }),
--   null_ls.builtins.formatting.puppet_lint.with({
--     condition = function() return vim.fn.executable("puppet-lint") > 0 end,
--   }),
--   null_ls.builtins.formatting.rubocop.with({
--     condition = function() return vim.fn.executable("rubocop") > 0 end,
--     prefer_local = true,
--   }),
--   null_ls.builtins.diagnostics.rubocop.with({
--     condition = function() return vim.fn.executable("rubocop") > 0 end,
--     prefer_local = true,
--   }),
--   null_ls.builtins.code_actions.shellcheck.with({
--     condition = function() return vim.fn.executable("shellcheck") > 0 end,
--   }),
--   null_ls.builtins.diagnostics.shellcheck.with({
--     condition = function() return vim.fn.executable("shellcheck") > 0 end,
--   }),
-- }

null_ls.setup({ sources = sources })



-- local sources = { null_ls.builtins.code_actions.gitsigns }
-- local sources = { null_ls.builtins.code_actions.shellcheck }
--
-- local sources = { null_ls.builtins.diagnostics.ansiblelint }
-- local sources = { null_ls.builtins.diagnostics.credo }
-- local sources = { null_ls.builtins.diagnostics.puppet_lint }
-- local sources = { null_ls.builtins.diagnostics.rubocop }
-- local sources = { null_ls.builtins.diagnostics.shellcheck }


-- Diagnostics [NVIM 0.6 only]
vim.diagnostic.config({
  virtual_text = false,
  -- virtual_text = {
  --   prefix = '■', -- Could be '●', '▎', 'x'
  --   spacing = 4,
  --   severity_limit = 'Warning',
  --   format = function(diagnostic)
  --     return string.format("%s: %s", diagnostic.source, diagnostic.message)
  --   end,
  -- },
  underline = false,
  float = {
    source = "always",
  },
  severity_sort = true,
  signs = true,
  update_in_insert = false,
})


-- Change diagnostic symbols in the sign column (gutter)
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

