-- ===============================================
-- Who:   Sven Sporer <<||>> sohooo
-- Where: https://github.com/sohooo/nvim
-- ===============================================
-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
-- NVIM v0.10.0 Build type: Release LuaJIT 2.1.1713773202

-- util functions {{{
function Hifi()
  -- non-nerdfont compatible signs
  -- ⚠ ☒ ★ ☆ ☼♡ ♢ ► ⊗ ⊖ ⊙ ⊛ ⊠ ⊹ ⋇ ⋗ ⋯ ◌ ●
  -- Ⓐ Ⓑ Ⓒ Ⓓ Ⓔ Ⓕ Ⓖ Ⓗ Ⓘ Ⓙ Ⓚ Ⓛ Ⓜ Ⓝ Ⓞ Ⓟ Ⓠ Ⓡ Ⓢ Ⓣ Ⓤ Ⓥ Ⓦ Ⓧ Ⓨ Ⓩ
  local style = os.getenv("NVIM_STYLE")
  return style ~= "plain"
end

-- custom settings based on GIT_USERNAME env variable
function MyColors()
  local style = {
    default = {
      colorscheme = "neofusion",
      lualine = require("neofusion.lualine"),
      -- colorscheme = "tokyonight",
      -- lualine = "tokyonight",
      -- colorscheme = "oxocarbon",
      -- lualine = "oxocarbon",
      -- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      -- lualine = "catppuccin"
      --
      -- https://github.com/rebelot/kanagawa.nvim
      -- kanagawa-wave
      -- kanagawa-dragon
      -- kanagawa-lotus
      --
      -- colorscheme = "nordic",
      -- colorscheme = "onenord",
      -- colorscheme = "oxocarbon",
      --
      -- colorscheme = "onedark",
      -- lualine = "onedark",
    },
    pUSER = {
      colorscheme = "nord",
      lualine = "nord",
    }
  }

  local wanted = os.getenv("GIT_USERNAME")
  return style[wanted] or style["default"]
end
-- }}}

-- plugins {{{
-- bootstrap lazy.nvim
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ','
vim.g.mapleader = ','

require("lazy").setup({
  -- telescope {{{
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  -- }}}
--
  -- addons, layout {{{
  'stevearc/dressing.nvim', -- improve default vim.ui interfaces
  'tpope/vim-fugitive', -- Git commands in nvim
  'tpope/vim-dispatch', -- async build/test dispatcher
  'folke/which-key.nvim', -- key bindings
  'folke/todo-comments.nvim',
  'levouh/tint.nvim', -- dim inactive windows
  'nacro90/numb.nvim', -- peeks lines of the buffer

  'hoob3rt/lualine.nvim',
  'kdheepak/tabline.nvim',
  'famiu/bufdelete.nvim',

  'kyazdani42/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',

  {
    "HampusHauffman/block.nvim",
    config = function()
      require("block").setup({})
    end
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, },
  "akinsho/toggleterm.nvim",
  "samjwill/nvim-unception", --open via Neovim's terminal without nesting sessions
  'rmagatti/goto-preview',
  'norcalli/nvim-colorizer.lua',
  { 'beauwilliams/focus.nvim', lazy = true }, -- Auto-Focusing and Auto-Resizing Splits/Windows

  { 'folke/noice.nvim', dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- "rcarriga/nvim-notify",
  }},
  -- }}}

  -- languages {{{
  'rodjek/vim-puppet',
  'fatih/vim-go',
  'simrat39/rust-tools.nvim',
  'mfussenegger/nvim-dap', -- Debugging
  'PedramNavid/dbtpal', -- dbt features
  { 'folke/neodev.nvim', enabled = false },-- additional lua config for neovim root_dir
  -- }}}

  -- helpers {{{
  'xorid/asciitree.nvim', -- :AsciiTree [2 #] [default]

  -- }}}

  -- editing tools {{{
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }},
  'sindrets/diffview.nvim',
  'tpope/vim-repeat', -- make '.' usable for plugins
  'numToStr/Comment.nvim', -- smart commenting plugin
  'ggandor/leap.nvim', -- fast jumping with s|S
  {
    'ggandor/flit.nvim', config = function()
      -- Enhanced f/t motions for Leap
      require('flit').setup {}
    end
  },
  'sickill/vim-pasta', -- pasting with indentation adjusted
  'stefandtw/quickfix-reflector.vim', -- Change code right in the quickfix window
  'windwp/nvim-autopairs',
  'abecodes/tabout.nvim',
  'RRethy/vim-illuminate', -- highlight current word
  { 'jiaoshijie/undotree', dependencies = { 'nvim-lua/plenary.nvim' }},
  { 'echasnovski/mini.align', version = '*' },

  {
    "smjonas/live-command.nvim", config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" }, -- previewable :Norm
        },
      }
    end,
  },

  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  { "ThePrimeagen/refactoring.nvim", config = function()
      require("refactoring").setup({})
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    "cshuaimin/ssr.nvim",
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>cR", function()
        require("ssr").open()
      end, { desc = "Structural Replace" })
    end,
  },
  -- }}}

  -- treesitter {{{
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
    build = ":TSUpdate",
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring', dependencies = { 'nvim-treesitter' }},
  { 'RRethy/nvim-treesitter-textsubjects', dependencies = { 'nvim-treesitter' }},
  { 'RRethy/nvim-treesitter-endwise', dependencies = { 'nvim-treesitter' }},
  { 'romgrk/nvim-treesitter-context', dependencies = { 'nvim-treesitter' }},
  { 'ckolkey/ts-node-action', dependencies = { 'nvim-treesitter' }},
  { 'windwp/nvim-ts-autotag', dependencies = { 'nvim-treesitter' }},
  { 'p00f/nvim-ts-rainbow', dependencies = { 'nvim-treesitter' }},
  -- }}}

  -- lsp, completion, snippets {{{
  'onsails/lspkind-nvim', -- icons in lsp popups etc
  'j-hui/fidget.nvim', -- Standalone UI for nvim-lsp progress
  'neovim/nvim-lspconfig',
  -- Autocomplete
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  -- linter, formatter, ...
  'jose-elias-alvarez/null-ls.nvim',

  -- colorschemes {{{
  'arcticicestudio/nord-vim',

  { "catppuccin/nvim", name = "catppuccin" },
  'nyoom-engineering/oxocarbon.nvim',
  'navarasu/onedark.nvim',
  'PHSix/nvim-hybrid',
  'rmehri01/onenord.nvim',
  'AlexvZyl/nordic.nvim',
  'shaunsingh/moonlight.nvim',
  'shaunsingh/doom-vibrant.nvim',
  'folke/tokyonight.nvim',
  'rebelot/kanagawa.nvim',
  'diegoulloao/neofusion.nvim',
  -- }}}
})

-- }}}
-- }}}

-- options {{{
vim.o.inccommand = 'split'        -- show regex previews
vim.o.hlsearch = true             -- set highlight on search
vim.o.incsearch = true            -- show matches while typing
vim.o.showmatch = true            -- show matching brackets
vim.o.matchtime = 2               -- how many tenths of a second to blink
vim.wo.number = true              -- make line numbers default
vim.wo.relativenumber = true      -- relative to current pos
vim.o.scrolloff=8                 -- show 8 lines of context around cursor
vim.o.hidden = true               -- do not save when switching buffers
vim.o.mouse = ''                  -- disable mouse
vim.o.breakindent = true          -- wrapped line with same indentation
vim.opt.undofile = true           -- save undo history
vim.o.ignorecase = true           -- case insensitive searching
vim.o.smartcase = true            -- ...unless /C or capital in search
vim.o.expandtab = true            -- insert spaces on <tab>
vim.o.updatetime = 250            -- decrease update time (4000)
vim.o.timeout = true              -- wait timeoutlen ms
vim.o.timeoutlen = 400            -- wait for seq. to complete (1000)
vim.wo.signcolumn = 'yes:1'       -- always draw sign col
vim.o.laststatus = 2              -- set to 3 for global statusline
vim.o.splitbelow = true           -- default: above
vim.o.splitright = true           -- default: on the left


if Hifi() then
	--Set colorscheme (order is important here)
	vim.o.termguicolors = true
	-- vim.cmd [[colorscheme tokyonight]]
  vim.cmd('colorscheme ' .. MyColors()['colorscheme'])
	vim.g.tokyonight_style = 'night' -- storm | night | day
else
	vim.o.termguicolors = false
	vim.cmd [[colorscheme nord]]
	-- vim.cmd [[colorscheme iceberg]]
	-- vim.g.onedark_terminal_italics = 2
	-- vim.g.onedark_termcolors = 256
	-- vim.cmd [[colorscheme onedark]]
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

vim.cmd [[set iskeyword+=-]]
-- }}}

-- requires {{{
require('sohooo/misc')
require('sohooo/treesitter')
require('sohooo/todo-comments')
require('sohooo/telescope')
require('sohooo/lsp')
require('sohooo/null-ls')
require('sohooo/toggleterm')
require('sohooo/gitsigns')
require('sohooo/lualine')
require('sohooo/noice')
require('sohooo/nvim-tree')
require('sohooo/focus')
require('sohooo/neotest')

require('mini.align').setup()
require("ibl").setup()
require('undotree').setup()
require('tabout').setup()
-- https://github.com/j-hui/fidget.nvim/blob/main/doc/fidget.md
require('fidget').setup({
  progress = {
    display = {
      done_ttl = 6, -- def: 3
    }
  }
})
require('sohooo/rust-tools')  -- included now in lsp-zero

if Hifi() then
	require('colorizer').setup()
end

require('Comment').setup()
require('goto-preview').setup{}
require('nvim-autopairs').setup{}
require('leap').set_default_keymaps()
require('tint').setup()
require('numb').setup()
-- require("ibl").setup() -- v3

require('sohooo/autocmds')
require('sohooo/which-key')
-- }}}

