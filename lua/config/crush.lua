local M = {}

local function executable()
  return vim.fn.executable("crush") == 1
end

local function notify_missing()
  vim.notify("crush is not available on PATH", vim.log.levels.WARN, { title = "Crush" })
end

local function root()
  local ok, lazyvim = pcall(require, "lazyvim.util")
  if ok and lazyvim.root then
    return lazyvim.root()
  end

  if LazyVim and LazyVim.root then
    return LazyVim.root()
  end

  return vim.uv.cwd()
end

local function shell_join(args)
  local escaped = {}
  for _, arg in ipairs(args) do
    table.insert(escaped, vim.fn.shellescape(arg))
  end
  return table.concat(escaped, " ")
end

local function terminal(command, opts)
  if not executable() then
    notify_missing()
    return
  end

  Snacks.terminal(command, vim.tbl_deep_extend("force", {
    cwd = root(),
    win = {
      position = "float",
      height = 0.9,
      width = 0.9,
      border = "single",
    },
  }, opts or {}))
end

local function terminal_shell(command, opts)
  local keep_open = "printf '\\n[crush exited; press Enter to close] '; read _"
  terminal(shell_join({ "sh", "-lc", command .. "; " .. keep_open }), opts)
end

local function tmp_context_path()
  local dir = vim.fs.joinpath(vim.fn.stdpath("run"), "crush")
  vim.fn.mkdir(dir, "p")
  return vim.fs.joinpath(dir, string.format("context-%d-%d.txt", vim.fn.getpid(), vim.uv.hrtime()))
end

local function write_context(lines)
  local path = tmp_context_path()
  vim.fn.writefile(lines, path, "b")
  return path
end

local function current_file_context()
  local name = vim.api.nvim_buf_get_name(0)
  local display_name = name ~= "" and name or "[No Name]"
  local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  table.insert(lines, "```")
  table.insert(lines, 1, "```" .. filetype)
  table.insert(lines, 1, "")
  table.insert(lines, 1, "File: " .. display_name)

  return lines
end

local function selected_context()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return nil
  end

  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  local name = vim.api.nvim_buf_get_name(0)
  local display_name = name ~= "" and name or "[No Name]"
  local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "text"

  table.insert(lines, "```")
  table.insert(lines, 1, "```" .. filetype)
  table.insert(lines, 1, "")
  table.insert(lines, 1, string.format("Selection: %s:%d-%d", display_name, start_line, end_line))

  return lines
end

local function ask_with_context(lines, continue)
  if not lines then
    vim.notify("No context selected for Crush", vim.log.levels.WARN, { title = "Crush" })
    return
  end

  if not executable() then
    notify_missing()
    return
  end

  vim.ui.input({ prompt = "Crush prompt: " }, function(prompt)
    if not prompt or prompt == "" then
      return
    end

    local path = write_context(lines)
    local args = { "crush", "run", "--cwd", root() }
    if continue then
      table.insert(args, "--continue")
    end
    table.insert(args, prompt)

    terminal_shell(shell_join(args) .. " < " .. vim.fn.shellescape(path))
  end)
end

function M.open()
  terminal(shell_join({ "crush", "--cwd", root() }))
end

function M.continue()
  terminal(shell_join({ "crush", "--continue", "--cwd", root() }))
end

function M.ask_file()
  ask_with_context(current_file_context(), false)
end

function M.continue_file()
  ask_with_context(current_file_context(), true)
end

function M.ask_selection()
  ask_with_context(selected_context(), false)
end

function M.continue_selection()
  ask_with_context(selected_context(), true)
end

function M.logs()
  terminal_shell(shell_join({ "crush", "logs", "--cwd", root() }))
end

function M.models()
  terminal_shell(shell_join({ "crush", "models", "--cwd", root() }))
end

M.executable = executable
M.root = root

return M
