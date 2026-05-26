local function buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)
  return name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
end

local function prompt_directory(prompt, callback)
  vim.ui.input({
    prompt = prompt,
    default = buffer_dir(),
    completion = "dir",
  }, function(input)
    if input and input ~= "" then
      callback(vim.fn.fnamemodify(input, ":p"))
    end
  end)
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>f", LazyVim.pick("files"), desc = "Find Files" },
      {
        "<leader>F",
        function()
          prompt_directory("Snacks files directory: ", function(dir)
            Snacks.picker.files({ cwd = dir })
          end)
        end,
        desc = "Find Files In Directory",
      },
      { "<leader>b", function() Snacks.picker.buffers() end, desc = "Open Buffers" },
      { "<leader>s", LazyVim.pick("live_grep"), desc = "Live Grep" },
      {
        "<leader>S",
        function()
          prompt_directory("Snacks grep directory: ", function(dir)
            Snacks.picker.grep({ cwd = dir })
          end)
        end,
        desc = "Live Grep In Directory",
      },
      { "<leader>l", function() Snacks.picker.resume() end, desc = "Last Search" },
      { "<leader>th", function() Snacks.picker.help() end, desc = "Help Tags" },
      { "<leader>tc", function() Snacks.picker.colorschemes() end, desc = "Colorscheme" },
      {
        "<leader>ts",
        function()
          Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter })
        end,
        desc = "Goto Symbol",
      },
      { "<leader>fb", false },
      { "<leader>fB", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>fp", false },
      { "<leader>sb", false },
      { "<leader>sB", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sp", false },
      { "<leader>sw", false, mode = { "n", "x" } },
      { "<leader>sW", false, mode = { "n", "x" } },
      { '<leader>s"', false },
      { "<leader>s/", false },
      { "<leader>sa", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>si", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>su", false },
      { "<leader>pfb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>pfB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
      { "<leader>pfc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>pff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>pfF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>pfg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
      { "<leader>pfr", LazyVim.pick("oldfiles"), desc = "Recent" },
      { "<leader>pfR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Recent (cwd)" },
      { "<leader>pfp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>psb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>psB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>psg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>psG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>psp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      {
        "<leader>psw",
        LazyVim.pick("grep_word"),
        desc = "Visual selection or word (Root Dir)",
        mode = { "n", "x" },
      },
      {
        "<leader>psW",
        LazyVim.pick("grep_word", { root = false }),
        desc = "Visual selection or word (cwd)",
        mode = { "n", "x" },
      },
      { '<leader>ps"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>ps/", function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>psa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>psc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>psC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>psd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>psD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>psh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>psH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>psi", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>psj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>psk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>psl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>psM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>psm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>psR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>psq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>psu", function() Snacks.picker.undo() end, desc = "Undotree" },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", false, mode = { "n", "x" } },
      {
        "<leader>psr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace",
      },
    },
  },
  {
    "folke/noice.nvim",
    keys = {
      { "<leader>sn", false },
      { "<leader>snl", false },
      { "<leader>snh", false },
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snt", false },
      { "<leader>psn", "", desc = "+noice" },
      { "<leader>psnl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>psnh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>psna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>psnd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>psnt", function() require("noice").cmd("pick") end, desc = "Noice Picker" },
    },
  },
  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>st", false },
      { "<leader>sT", false },
      { "<leader>pst", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      {
        "<leader>psT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
}
