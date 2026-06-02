local function assert_require(name)
  local ok = pcall(require, name)
  assert(ok, "failed to require " .. name)
end

assert(vim.g.mapleader == ",", "mapleader should be comma")
assert(vim.g.maplocalleader == ",", "maplocalleader should be comma")
assert(vim.o.inccommand == "split", "inccommand should use split previews")
assert(vim.o.scrolloff == 8, "scrolloff should be 8")
assert(vim.o.mouse == "", "mouse should be disabled")
assert(vim.o.timeoutlen == 400, "timeoutlen should be 400")
assert(vim.o.signcolumn == "yes:2", "signcolumn should be yes:2")
assert(vim.o.numberwidth == 4, "numberwidth should be 4")
assert(vim.o.statuscolumn == "%s%=%l ", "statuscolumn should be fixed")
assert(vim.o.iskeyword:find("-", 1, true) ~= nil, "iskeyword should include dash")

assert_require("config.lsp")
assert_require("config.style")
assert_require("config.filetypes")
assert_require("config.health")
assert_require("config.theme")
assert(require("config.style").icons_enabled() == (vim.env.NVIM_STYLE ~= "plain"), "style icon preference mismatch")
local theme = require("config.theme")
assert(theme.current("").name == "default", "empty GIT_USERNAME should use default theme profile")
assert(theme.current("unknown").name == "default", "unknown GIT_USERNAME should use default theme profile")
assert(theme.current("pUSER").name == "pUSER", "pUSER should select pUSER theme profile")
assert(theme.current("pUSER").colorscheme == "nord", "pUSER colorscheme should be nord")
assert(theme.current("pUSER").lualine == "nord", "pUSER lualine should be nord")
assert(theme.colorscheme() == theme.current().colorscheme, "theme colorscheme helper mismatch")
assert(theme.lualine_theme() == (theme.current().lualine or theme.current().colorscheme), "theme lualine helper mismatch")
local bufferline_highlights = theme.bufferline_highlights()
assert(bufferline_highlights == nil or type(bufferline_highlights) == "table", "bufferline highlights should be optional table")
assert(vim.g.loaded_node_provider == 0, "node provider should be disabled")
assert(vim.g.loaded_perl_provider == 0, "perl provider should be disabled")
assert(vim.g.loaded_python3_provider == 0, "python provider should be disabled")
assert(vim.g.loaded_ruby_provider == 0, "ruby provider should be disabled")
assert(vim.filetype.match({ filename = "example.gotmpl" }) == "gotmpl", "gotmpl filetype should be registered")
assert(vim.filetype.match({ filename = "manifests/site.pp" }) == "puppet", "puppet filetype should be registered")

local function assert_contains(values, expected, label)
  for _, value in ipairs(values or {}) do
    if value == expected then
      return
    end
  end

  error(label .. " should contain " .. expected)
end

local function assert_cmd(name, expected)
  local config = vim.lsp.config[name]
  assert(config ~= nil, "missing LSP config " .. name)

  for index, value in ipairs(expected) do
    assert(config.cmd[index] == value, name .. " cmd mismatch at " .. index)
  end
end

assert(vim.lsp.config["*"].capabilities.textDocument.completion ~= nil, "missing LSP completion capabilities")

assert_cmd("gopls", { "gopls" })
assert_contains(vim.lsp.config.gopls.filetypes, "go", "gopls filetypes")
assert_contains(vim.lsp.config.gopls.root_markers, "go.mod", "gopls root markers")

assert_cmd("ruff", { "ruff", "server" })
assert_contains(vim.lsp.config.ruff.filetypes, "python", "ruff filetypes")
assert_contains(vim.lsp.config.ruff.root_markers, "pyproject.toml", "ruff root markers")

assert_cmd("rust_analyzer", { "rust-analyzer" })
assert_contains(vim.lsp.config.rust_analyzer.filetypes, "rust", "rust_analyzer filetypes")
assert_contains(vim.lsp.config.rust_analyzer.root_markers, "Cargo.toml", "rust_analyzer root markers")

assert_cmd("ruby-lsp", { "ruby-lsp" })
assert_contains(vim.lsp.config["ruby-lsp"].filetypes, "ruby", "ruby-lsp filetypes")
assert_contains(vim.lsp.config["ruby-lsp"].root_markers, "Gemfile", "ruby-lsp root markers")
assert(vim.lsp.config["ruby-lsp"].init_options.formatter == "standard", "ruby-lsp formatter should be standard")

assert_cmd("lua_ls", { "lua-language-server" })
assert_contains(vim.lsp.config.lua_ls.filetypes, "lua", "lua_ls filetypes")
assert_contains(vim.lsp.config.lua_ls.root_markers, ".luarc.json", "lua_ls root markers")
assert(vim.lsp.config.lua_ls.settings.Lua.runtime.version == "LuaJIT", "lua_ls should use LuaJIT runtime")

assert_cmd("puppet", { "puppet-languageserver", "--stdio", "--timeout=10", "--puppet-settings=--modulepath,/modules" })
assert_contains(vim.lsp.config.puppet.filetypes, "puppet", "puppet filetypes")
assert_contains(vim.lsp.config.puppet.root_markers, "Puppetfile", "puppet root markers")

local lsp_buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(lsp_buf)
vim.api.nvim_exec_autocmds("LspAttach", { buffer = lsp_buf, data = { client_id = 0 } })
for _, mapping in ipairs({ "gd", "gr", "gI", "gy", "gD", "K", "gK", "<leader>ca", "<leader>cr", "<leader>cl" }) do
  assert(vim.fn.maparg(mapping, "n") ~= "", "missing LSP normal mapping " .. mapping)
end
assert(vim.fn.maparg("<C-k>", "i") ~= "", "missing LSP insert signature mapping")

local treesitter_parsers = {
  bash = { filetypes = { "sh" } },
  embedded_template = { filetypes = { "eruby" } },
  go = { filetypes = { "go" } },
  gomod = { filetypes = { "gomod" } },
  gosum = { filetypes = { "gosum" } },
  gotmpl = { filetypes = { "gotmpl" } },
  lua = { filetypes = { "lua" } },
  puppet = { filetypes = { "puppet" } },
  python = { filetypes = { "python" } },
  ruby = { filetypes = { "ruby" } },
  rust = { filetypes = { "rust" } },
  yaml = { filetypes = { "yaml" } },
}

local treesitter_opts = require("lazy.core.config").spec.plugins["nvim-treesitter"].opts
local available_parsers = require("nvim-treesitter.config").get_available()
local installed_parsers = require("nvim-treesitter.config").get_installed("parsers")

for parser, spec in pairs(treesitter_parsers) do
  if vim.env.NVIM_AIRGAP ~= "1" then
    assert_contains(treesitter_opts.ensure_installed, parser, "treesitter ensure_installed")
  end
  assert_contains(available_parsers, parser, "treesitter available parsers")

  for _, filetype in ipairs(spec.filetypes) do
    assert(vim.treesitter.language.get_lang(filetype) == parser, "treesitter parser alias mismatch for " .. filetype)
  end

  if vim.list_contains(installed_parsers, parser) then
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
    assert(vim.treesitter.get_parser(buf, parser) ~= nil, "failed to create treesitter parser for " .. parser)
  end
end

for _, name in ipairs({
  "bufferline",
  "gitsigns",
  "grug-far",
  "lualine",
  "mini.align",
  "mini.comment",
  "mini.icons",
  "mini.jump",
  "mini.pairs",
  "mini.snippets",
  "mini.splitjoin",
  "mini.surround",
  "mini.trailspace",
  "noice",
  "snacks",
  "todo-comments",
  "treesitter-context",
  "which-key",
}) do
  assert_require(name)
end

assert(vim.ui.input == Snacks.input.input, "vim.ui.input should use Snacks.input")
assert(vim.ui.select == Snacks.picker.select, "vim.ui.select should use Snacks.picker.select")

for _, mapping in ipairs({
  "<leader>f",
  "<leader>F",
  "<leader>Bb",
  "<leader>Bd",
  "<leader>Bp",
  "<leader>pff",
  "<leader>pfb",
  "<leader>psg",
  "<leader>psr",
  "<leader>pst",
  "<leader>psT",
  "<leader>d",
  "<leader>l",
  "<leader>b",
  "<leader>s",
  "<leader>S",
  "<leader>te",
  "<leader>tt",
  "<leader>tg",
  "<leader>tph",
  "<leader>tpp",
  "<leader>tps",
  "<leader>q",
  "<leader>u",
  "<leader>cw",
  "<Tab>",
  "<S-Tab>",
  "mf",
  "ga",
  "gA",
  "gS",
  "gsa",
}) do
  assert(vim.fn.maparg(mapping, "n") ~= "", "missing normal mapping " .. mapping)
end

for _, mapping in ipairs({
  "<leader>ff",
  "<leader>fb",
  "<leader>bp",
  "<leader>bP",
  "<leader>br",
  "<leader>bl",
  "<leader>bj",
  "<leader>bb",
  "<leader>bd",
  "<leader>bo",
  "<leader>bi",
  "<leader>bD",
  "<leader>dph",
  "<leader>dpp",
  "<leader>dps",
  "<leader>fe",
  "<leader>ft",
  "<leader>sg",
  "<leader>sr",
  "<leader>st",
  "<leader>snl",
}) do
  assert(vim.fn.maparg(mapping, "n") == "", "unexpected conflicting normal mapping " .. mapping)
end

for _, mapping in ipairs({
  "<leader>sw",
  "<leader>sW",
  "<leader>sr",
}) do
  assert(vim.fn.maparg(mapping, "x") == "", "unexpected conflicting visual mapping " .. mapping)
end

assert(vim.fn.maparg("<Esc><Esc>", "t") ~= "", "missing terminal escape mapping")

vim.cmd.packadd("nvim.undotree")
assert(vim.fn.exists(":Undotree") == 2, "missing native :Undotree")
assert(type(require("undotree").open) == "function", "missing undotree.open")
assert(vim.fn.exists(":Git") == 2, "missing :Git")
vim.cmd("silent Git --version")
assert(vim.fn.exists(":Dispatch") == 2, "missing :Dispatch")
assert(vim.fn.exists(":Make") == 2, "missing :Make")
assert(vim.fn.exists(":Focus") == 2, "missing :Focus")
assert(vim.fn.exists(":Start") == 2, "missing :Start")

for _, scheme in ipairs({
  "nord",
  "catppuccin",
  "catppuccin-latte",
  "catppuccin-frappe",
  "catppuccin-macchiato",
  "catppuccin-mocha",
  "kanagawa",
  "kanagawa-wave",
  "kanagawa-dragon",
  "kanagawa-lotus",
}) do
  vim.cmd.colorscheme(scheme)
end
