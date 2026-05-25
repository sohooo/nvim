local style = require("config.style")

local function buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)

  if name == "" then
    return vim.uv.cwd()
  end

  return vim.fs.dirname(name)
end

local function prompt_directory(callback)
  vim.ui.input({
    prompt = "Telescope directory: ",
    default = buffer_dir(),
    completion = "dir",
  }, function(input)
    if not input or input == "" then
      return
    end

    callback(vim.fn.fnamemodify(input, ":p"))
  end)
end

local function project_files()
  local builtin = require("telescope.builtin")
  local opts = { disable_devicons = not style.icons_enabled() }
  local ok = pcall(builtin.git_files, opts)

  if not ok then
    builtin.find_files(opts)
  end
end

local function directory_files()
  prompt_directory(function(dir)
    require("telescope.builtin").find_files({
      cwd = dir,
      disable_devicons = not style.icons_enabled(),
      prompt_title = "Find Files: " .. vim.fn.fnamemodify(dir, ":~:."),
    })
  end)
end

local function directory_grep()
  prompt_directory(function(dir)
    require("telescope.builtin").live_grep({
      cwd = dir,
      prompt_title = "Live Grep: " .. vim.fn.fnamemodify(dir, ":~:."),
    })
  end)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>f", project_files, desc = "Telescope Find File" },
      { "<leader>F", directory_files, desc = "Telescope Find File In Directory" },
      { "<leader>l", "<cmd>Telescope resume<cr>", desc = "Telescope Last Search" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope Open Buffers" },
      { "<leader>s", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
      { "<leader>S", directory_grep, desc = "Telescope Live Grep In Directory" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Telescope Help Tags" },
      {
        "<leader>tc",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Telescope Colorscheme",
      },
      {
        "<leader>ts",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
            sorting_strategy = "ascending",
          })
        end,
        desc = "Telescope Goto Symbol",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        disable_devicons = not style.icons_enabled(),
        color_devicons = true,
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          buffers = {
            disable_devicons = not style.icons_enabled(),
            sort_lastused = true,
            theme = "dropdown",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["<C-d>"] = actions.delete_buffer,
              },
            },
          },
          find_files = {
            disable_devicons = not style.icons_enabled(),
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
