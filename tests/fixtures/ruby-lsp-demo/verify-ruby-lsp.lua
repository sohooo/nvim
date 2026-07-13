local function fail(message)
  error(message, 0)
end

local function wait_for_client()
  local deadline = vim.uv.now() + 15000

  while vim.uv.now() < deadline do
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      if client.name == "ruby_lsp" or client.name == "ruby-lsp" then
        return client
      end
    end

    vim.wait(100)
  end

  fail("ruby_lsp did not attach to the demo buffer")
end

local function find_position(pattern)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for row, line in ipairs(lines) do
    local start_col = line:find(pattern, 1, true)
    if start_col then
      return row - 1, start_col - 1
    end
  end

  fail("pattern not found in demo buffer: " .. pattern)
end

local function request(method, params)
  local results = vim.lsp.buf_request_sync(0, method, params, 10000)
  if not results then
    fail(method .. " returned no response")
  end

  for _, response in pairs(results) do
    if response.err then
      fail(method .. " failed: " .. vim.inspect(response.err))
    end
    if response.result ~= nil then
      return response.result
    end
  end

  fail(method .. " returned no result")
end

local client = wait_for_client()
local capabilities = client.server_capabilities

assert(capabilities.definitionProvider, "ruby_lsp should provide definitions")
assert(capabilities.hoverProvider, "ruby_lsp should provide hover")
assert(capabilities.documentSymbolProvider, "ruby_lsp should provide document symbols")
assert(capabilities.referencesProvider, "ruby_lsp should provide references")
assert(capabilities.renameProvider, "ruby_lsp should provide rename")

local add_row, add_col = find_position("add")
local text_document = vim.lsp.util.make_text_document_params(0)
local position = { line = add_row, character = add_col }

local definition = request("textDocument/definition", {
  textDocument = text_document,
  position = position,
})
local definition_items = vim.islist(definition) and definition or { definition }
local found_definition = false
for _, item in ipairs(definition_items) do
  local uri = item.uri or item.targetUri
  if uri and uri:find("calculator%.rb") then
    found_definition = true
    break
  end
end
assert(found_definition, "definition for add should point to calculator.rb")

request("textDocument/hover", {
  textDocument = text_document,
  position = position,
})

local symbols = request("textDocument/documentSymbol", {
  textDocument = text_document,
})
assert(type(symbols) == "table", "document symbols should return a table")

local refs = request("textDocument/references", {
  textDocument = text_document,
  position = position,
  context = { includeDeclaration = true },
})
assert(type(refs) == "table", "references should return a table")

print("Ruby LSP demo check succeeded")
