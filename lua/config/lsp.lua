local M = {}

local function with_blink_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")

  if ok and type(blink.get_lsp_capabilities) == "function" then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  return capabilities
end

local function puppet_workspace()
  if vim.env.PUPPET_LSP_WORKSPACE and vim.env.PUPPET_LSP_WORKSPACE ~= "" then
    return vim.env.PUPPET_LSP_WORKSPACE
  end

  return string.format("%s/puppetenvs/kpm", vim.uv.os_homedir())
end

local function ruby_lsp_cmd()
  if vim.env.RUBY_LSP_CMD and vim.env.RUBY_LSP_CMD ~= "" then
    return { vim.env.RUBY_LSP_CMD }
  end

  return { "ruby-lsp" }
end

vim.lsp.config("*", {
  capabilities = with_blink_capabilities(),
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "⋇",
    spacing = 4,
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  underline = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("local-lsp-keymaps", { clear = true }),
  callback = function(event)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LSP Health")
  end,
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.tabnew(vim.lsp.log.get_filename())
end, { desc = "Open the native Neovim LSP log" })

vim.api.nvim_create_user_command("LspInfo", function()
  local lines = {}
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  local function format_cmd(cmd)
    if type(cmd) == "table" then
      return table.concat(cmd, " ")
    end
    return type(cmd)
  end

  table.insert(lines, "Buffer: " .. vim.api.nvim_buf_get_name(0))
  table.insert(lines, "Filetype: " .. vim.bo.filetype)
  table.insert(lines, "")

  if #clients == 0 then
    table.insert(lines, "No active LSP clients attached to this buffer.")
  else
    table.insert(lines, "Active LSP clients:")
    for _, client in ipairs(clients) do
      table.insert(lines, string.format("- %s", client.name))
      table.insert(lines, string.format("  root: %s", client.root_dir or ""))
      table.insert(lines, string.format("  cmd: %s", format_cmd(client.config.cmd)))
    end
  end

  vim.cmd.new()
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "markdown"
  vim.api.nvim_buf_set_name(0, "LspInfo")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Show native Neovim LSP clients for the current buffer" })

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gosum", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
})

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})

vim.lsp.config("ruby_lsp", {
  cmd = ruby_lsp_cmd(),
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" },
  init_options = {
    formatter = "auto",
    linters = {},
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("puppet", {
  cmd = {
    "puppet-languageserver",
    "--stdio",
    "--timeout=10",
    "--puppet-settings=--modulepath,/modules",
    "--local-workspace=" .. puppet_workspace(),
  },
  filetypes = { "puppet" },
  root_markers = { "metadata.json", "Puppetfile", ".git" },
})

vim.lsp.enable({
  "gopls",
  "ruff",
  "rust_analyzer",
  "ruby_lsp",
  "lua_ls",
  "puppet",
})

return M
