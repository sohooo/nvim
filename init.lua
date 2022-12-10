-- ===============================================
-- Who:   Sven Sporer <<||>> sohooo
-- Where: https://github.com/sohooo/nvim
-- ===============================================
-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
-- NVIM v0.8.0-dev+96-gd9dcfd021 LuaJIT 2.1.0-beta3

function Hifi()
	-- TODO: telescope icons
	-- non-nerdfont compatible signs
	-- ⚠ ☒ ★ ☆ ☼♡ ♢ ► ⊗ ⊖ ⊙ ⊛ ⊠ ⊹ ⋇ ⋗ ⋯ ◌ ●
	-- Ⓐ Ⓑ Ⓒ Ⓓ Ⓔ Ⓕ Ⓖ Ⓗ Ⓘ Ⓙ Ⓚ Ⓛ Ⓜ Ⓝ Ⓞ Ⓟ Ⓠ Ⓡ Ⓢ Ⓣ Ⓤ Ⓥ Ⓦ Ⓧ Ⓨ Ⓩ
	local style = os.getenv("NVIM_STYLE")
	return style ~= "plain"
end

-- plugins {{{
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	vim.cmd([[
	  augroup packer_user_config
	    autocmd!
	    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	  augroup end
	]])

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
	use 'diegoulloao/nvim-file-location'

	use { "kylechui/nvim-surround", tag = "*" } -- Use for stability; omit to use `main` branch for the latest features
	-- }}}

	-- treesitter {{{
	-- Plug 'lewis6991/spellsitter.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'JoosepAlviste/nvim-ts-context-commentstring'
	use 'RRethy/nvim-treesitter-endwise'
	use 'romgrk/nvim-treesitter-context'
	use 'windwp/nvim-ts-autotag'
	use 'p00f/nvim-ts-rainbow'
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
	-- --
	-- use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	-- use 'hrsh7th/cmp-nvim-lsp'
	-- use 'hrsh7th/cmp-nvim-lua'
	-- use 'hrsh7th/cmp-buffer'
	-- use 'hrsh7th/cmp-path'
	-- use 'hrsh7th/cmp-cmdline'
	-- use 'hrsh7th/cmp-vsnip'
	-- use 'hrsh7th/vim-vsnip'
	-- use 'rafamadriz/friendly-snippets'
	-- }}}

	-- colorschemes {{{
	use 'cocopon/iceberg.vim'
	use 'joshdick/onedark.vim'
	use 'arcticicestudio/nord-vim'

	use 'PHSix/nvim-hybrid'
	use 'rmehri01/onenord.nvim'
	use 'shaunsingh/moonlight.nvim'
	use 'shaunsingh/doom-vibrant.nvim'
	use 'folke/tokyonight.nvim'

	-- eval

	-- }}}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
-- }}}

-- options {{{
vim.o.inccommand = 'split'        -- show regex previews
vim.o.hlsearch = true             -- set highlight on search
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
	vim.cmd [[colorscheme tokyonight]]
	vim.g.tokyonight_style = "night" -- storm | night | day
else
	vim.o.termguicolors = false
	vim.cmd [[colorscheme nord]]
	-- vim.cmd [[colorscheme iceberg]]
	-- vim.g.onedark_terminal_italics = 2
	-- vim.g.onedark_termcolors = 256
	-- vim.cmd [[colorscheme onedark]]
end
-- }}}

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

vim.cmd [[set iskeyword+=-]]

-- includes
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

