local parser_aliases = {
  eruby = "embedded_template",
  sh = "bash",
}

local parser_languages = {
  "bash",
  "embedded_template",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "lua",
  "puppet",
  "python",
  "ruby",
  "rust",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      for filetype, parser in pairs(parser_aliases) do
        vim.treesitter.language.register(parser, filetype)
      end
    end,
    opts = {
      ensure_installed = parser_languages,
    },
  },
}
