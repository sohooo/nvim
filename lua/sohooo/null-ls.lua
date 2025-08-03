local null_ls = require 'null-ls'

null_ls.setup {
  -- debug = true,
  -- debounce = 250,
  -- default_timeout = 5000,
  -- update_in_insert = true,
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck, -- shellcheck
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.ansiblelint, -- ansible-lint
    null_ls.builtins.diagnostics.erb_lint, -- erblint; `gem install erb_lint`
    null_ls.builtins.diagnostics.puppet_lint, -- puppet-lint
    -- null_ls.builtins.diagnostics.ruff, -- ruff
    -- null_ls.builtins.diagnostics.shellcheck, -- shellcheck
    null_ls.builtins.diagnostics.sqlfluff.with { -- sqlfluff
      extra_args = { '--dialect', 'postgres' },
    },
    null_ls.builtins.diagnostics.yamllint, -- yamllint
    null_ls.builtins.formatting.crystal_format, -- crystal
    null_ls.builtins.formatting.erb_format, -- erb-format
    null_ls.builtins.formatting.pg_format, -- pg_format
    null_ls.builtins.formatting.puppet_lint.with {
      -- puppet-lint
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      diagnostic_config = {
        -- see :help vim.diagnostic.config()
        update_in_insert = false,
        severity_sort = true,
      },
    },
    null_ls.builtins.formatting.shfmt, -- shfmt
    null_ls.builtins.formatting.stylua, -- stylua
    null_ls.builtins.formatting.yamlfmt, -- yamlfmt
  },
}
