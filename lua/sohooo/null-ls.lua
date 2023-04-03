local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.shellcheck, -- shellcheck
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.ansiblelint, -- ansible-lint
        null_ls.builtins.diagnostics.erb_lint, -- erblint
        null_ls.builtins.diagnostics.puppet_lint, -- puppet-lint
        null_ls.builtins.diagnostics.ruff, -- ruff
        null_ls.builtins.diagnostics.shellcheck, -- shellcheck
        null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
        }), -- sqlfluff
        null_ls.builtins.diagnostics.yamllint, -- yamllint
        null_ls.builtins.formatting.crystal_format, -- crystal
        null_ls.builtins.formatting.erb_format, -- erb-format
        null_ls.builtins.formatting.pg_format, -- pg_format
        null_ls.builtins.formatting.puppet_lint, -- puppet-lint
        null_ls.builtins.formatting.shfmt, -- shfmt
        null_ls.builtins.formatting.stylua, -- stylua
        null_ls.builtins.formatting.yamlfmt, -- yamlfmt
    },
})
