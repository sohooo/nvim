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
assert(vim.o.signcolumn == "yes:1", "signcolumn should be yes:1")
assert(vim.o.iskeyword:find("-", 1, true) ~= nil, "iskeyword should include dash")

assert_require("config.lsp")
assert_require("config.style")
assert(require("config.style").icons_enabled() == (vim.env.NVIM_STYLE ~= "plain"), "style icon preference mismatch")

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

for _, name in ipairs({
  "focus",
  "mini.align",
  "mini.bufremove",
  "mini.cmdline",
  "mini.comment",
  "mini.cursorword",
  "mini.diff",
  "mini.icons",
  "mini.indentscope",
  "mini.jump",
  "mini.pairs",
  "mini.snippets",
  "mini.splitjoin",
  "mini.statusline",
  "mini.surround",
  "mini.tabline",
  "mini.trailspace",
  "telescope",
  "telescope.builtin",
  "toggleterm",
  "which-key",
}) do
  assert_require(name)
end

for _, mapping in ipairs({
  "<leader>f",
  "<leader>l",
  "<leader>b",
  "<leader>s",
  "<leader>te",
  "<leader>tt",
  "<leader>tg",
  "<leader>q",
  "<leader>u",
  "<leader>cw",
  "ga",
  "gA",
  "gS",
  "gsa",
}) do
  assert(vim.fn.maparg(mapping, "n") ~= "", "missing normal mapping " .. mapping)
end

assert(vim.fn.maparg("<Esc><Esc>", "t") ~= "", "missing terminal escape mapping")

vim.cmd.packadd("nvim.undotree")
assert(vim.fn.exists(":Undotree") == 2, "missing native :Undotree")
assert(type(require("undotree").open) == "function", "missing undotree.open")
assert(vim.fn.exists(":ToggleTerm") == 2, "missing :ToggleTerm")
assert(vim.fn.exists(":TermExec") == 2, "missing :TermExec")
assert(vim.fn.exists(":Git") == 2, "missing :Git")
vim.cmd("silent Git --version")
assert(vim.fn.exists(":Dispatch") == 2, "missing :Dispatch")
assert(vim.fn.exists(":Make") == 2, "missing :Make")

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
