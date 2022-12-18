-- ===============================================
-- Who:   Sven Sporer <<||>> sohooo
-- Where: https://github.com/sohooo/nvim
-- ===============================================
-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
-- NVIM v0.8.1 Release LuaJIT 2.1.0-beta3

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
      colorscheme = "tokyonight",
      lualine = "tokyonight",
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
-- Automatically install packer on initial startup
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- telescope {{{
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- }}}

  -- addons, layout {{{
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-dispatch' -- async build/test dispatcher
  use 'folke/which-key.nvim' -- key bindings
  use 'folke/todo-comments.nvim'

  use 'hoob3rt/lualine.nvim'
  use 'kdheepak/tabline.nvim'

  if Hifi() then use 'kyazdani42/nvim-web-devicons' end
  use 'nvim-tree/nvim-tree.lua'
  use 'folke/trouble.nvim'

  use 'lukas-reineke/indent-blankline.nvim'
  use "akinsho/toggleterm.nvim"
  use "samjwill/nvim-unception" --open via Neovim's terminal without nesting sessions
  use 'rmagatti/goto-preview'
  use 'norcalli/nvim-colorizer.lua'
  use 'beauwilliams/focus.nvim' -- Auto-Focusing and Auto-Resizing Splits/Windows
  use 'karb94/neoscroll.nvim'
  -- }}}

  -- languages {{{
  use 'sheerun/vim-polyglot' -- the full kitchen sink
  use 'fatih/vim-go'
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap' -- Debugging
  -- }}}

  -- editing tools {{{
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'TimUntersberger/neogit'
  use 'mbbill/undotree'
  use 'tpope/vim-repeat' -- make '.' usable for plugins
  use 'numToStr/Comment.nvim' -- smart commenting plugin
  use 'andrewradev/splitjoin.vim' -- gS (split), gJ (join) code blocks
  use 'ggandor/leap.nvim' -- fast jumping with s|S
  use 'sickill/vim-pasta' -- pasting with indentation adjusted
  use 'stefandtw/quickfix-reflector.vim' -- Change code right in the quickfix window
  use 'windwp/nvim-autopairs'
  use 'junegunn/vim-easy-align'
  use 'abecodes/tabout.nvim'
  use 'vim-test/vim-test'
  use 'chentoast/marks.nvim'
  use 'RRethy/vim-illuminate'

  use { "kylechui/nvim-surround", tag = "*" } -- Use for stability; omit to use `main` branch for the latest features
  -- }}}

  -- treesitter {{{
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
  use { 'RRethy/nvim-treesitter-endwise', after = 'nvim-treesitter' }
  use { 'romgrk/nvim-treesitter-context', after = 'nvim-treesitter' }
  use { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }
  use { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }
  -- }}}

  -- lsp, completion, snippets {{{
  use 'onsails/lspkind-nvim' -- icons in lsp popups etc
  use 'j-hui/fidget.nvim' -- Standalone UI for nvim-lsp progress
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  -- colorschemes {{{
  use 'cocopon/iceberg.vim'
  use 'joshdick/onedark.vim'
  use 'arcticicestudio/nord-vim'

  use 'PHSix/nvim-hybrid'
  use 'rmehri01/onenord.nvim'
  use 'shaunsingh/moonlight.nvim'
  use 'shaunsingh/doom-vibrant.nvim'
  use 'folke/tokyonight.nvim'
  -- }}}

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- }}}

-- bootstrap {{{
-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
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
-- vim.o.mouse = 'a'                 -- Enable mouse mode
vim.o.breakindent = true          -- wrapped line with same indentation
vim.opt.undofile = true           -- save undo history
vim.o.ignorecase = true           -- case insensitive searching
vim.o.smartcase = true            -- ...unless /C or capital in search
vim.o.expandtab = true            -- insert spaces on <tab>
vim.o.updatetime = 250            -- decrease update time (4000)
vim.o.timeoutlen = 500            -- wait for seq. to complete (1000)
vim.wo.signcolumn = 'yes:1'         -- always draw sign col
vim.o.laststatus = 2              -- set to 3 for global statusline


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

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

vim.cmd [[set iskeyword+=-]]
-- }}}

-- requires {{{
require('sohooo/misc')
require('sohooo/treesitter')
require('sohooo/todo-comments')
require('sohooo/telescope')
-- require('sohooo/lsp')  -- replaced by lsp-zero
require('sohooo/lsp-zero')
require('sohooo/toggleterm')
require('sohooo/gitsigns')
require('sohooo/lualine')
require('sohooo/indent_blankline')
require('sohooo/neogit')
-- require('sohooo/nvim-cmp')  -- included now in lsp-zero
require('sohooo/nvim-tree')
require('sohooo/focus')

-- require('sohooo/trouble')

require('tabout').setup()
require('fidget').setup{}
-- require('sohooo/rust-tools')  -- included now in lsp-zero

if Hifi() then
	require('colorizer').setup()
end

require('Comment').setup()
require('goto-preview').setup{}
require('nvim-autopairs').setup{}
-- require('neoscroll').setup()
require('marks').setup{}
require("nvim-surround").setup({})
require('leap').set_default_keymaps()

require('sohooo/autocmds')
require('sohooo/keymaps')
-- }}}

