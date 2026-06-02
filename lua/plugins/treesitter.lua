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

local ensure_installed = parser_languages
if vim.env.NVIM_AIRGAP == "1" or vim.env.NVIM_AIRGAP_BUILD == "1" then
  ensure_installed = {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      for filetype, parser in pairs(parser_aliases) do
        vim.treesitter.language.register(parser, filetype)
      end
    end,
    opts = function(_, opts)
      opts.ensure_installed = ensure_installed
    end,
  },
}
