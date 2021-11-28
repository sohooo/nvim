-- ===============================================
-- Who:   Sven Sporer <<||>> sohooo
-- Where: https://github.com/sohooo/nvim
-- ===============================================
-- vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
-- NVIM v0.5.1 Build type: Release LuaJIT 2.1.0-beta3

-- plugins {{{
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- telescope {{{
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- }}}

  -- addons, layout {{{
    use 'neovim/nvim-lspconfig' -- configurations for built-in LSP client
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-dispatch' -- async build/test dispatcher
    use 'folke/which-key.nvim'
    use 'folke/todo-comments.nvim'

    use 'hoob3rt/lualine.nvim'
    use 'kdheepak/tabline.nvim'
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }
    use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }
    use 'lukas-reineke/indent-blankline.nvim'
    use "akinsho/toggleterm.nvim"
    use 'rmagatti/goto-preview'
    use 'norcalli/nvim-colorizer.lua'
    use 'beauwilliams/focus.nvim'
  -- }}}

  -- languages {{{
    use 'sheerun/vim-polyglot' -- the full kitchen sink
  -- }}}

  -- editing tools {{{
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'TimUntersberger/neogit'
    use 'mbbill/undotree'
    use 'tpope/vim-repeat' -- make '.' usable for plugins
    use 'tpope/vim-surround' -- quoting/parenthesizing made simple
    use "terrortylor/nvim-comment" -- comment with gc
    use 'andrewradev/splitjoin.vim' -- gS (split), gJ (join) code blocks
    use 'ggandor/lightspeed.nvim'
    use 'sickill/vim-pasta' -- pasting with indentation adjusted
    use 'stefandtw/quickfix-reflector.vim' -- Change code right in the quickfix window
    use 'windwp/nvim-autopairs'
    use 'junegunn/vim-easy-align'
    use 'abecodes/tabout.nvim'
    use 'vim-test/vim-test'
  -- }}}

  -- treesitter {{{
    -- Plug 'lewis6991/spellsitter.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'romgrk/nvim-treesitter-context'
    use 'windwp/nvim-ts-autotag'
    use 'p00f/nvim-ts-rainbow'
  -- }}}

  -- completion, snippets {{{
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
  -- }}}

  -- colorschemes {{{
    use 'cocopon/iceberg.vim'
    use 'joshdick/onedark.vim'
    use 'shaunsingh/moonlight.nvim'
    use 'shaunsingh/nord.nvim'
    use 'shaunsingh/doom-vibrant.nvim'
    use 'folke/tokyonight.nvim'
  -- }}}

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
vim.wo.signcolumn = 'yes'         -- always draw sign col


--Set colorscheme (order is important here)
vim.o.termguicolors = true
-- vim.g.onedark_terminal_italics = 2
-- vim.cmd [[colorscheme onedark]]
vim.cmd [[colorscheme tokyonight]]
vim.g.tokyonight_style = "night" -- storm | night | day
-- }}}

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- includes
require('sohooo/misc')
require('sohooo/treesitter')
require('sohooo/todo-comments')
require('sohooo/telescope')
require('sohooo/lsp')
require('sohooo/toggleterm')
require('sohooo/lightspeed')
require('sohooo/gitsigns')
require('sohooo/lualine')
require('sohooo/indent_blankline')
require('sohooo/neogit')
require('sohooo/nvim-cmp')
require('sohooo/nvim-tree')
require('sohooo/trouble')
require('sohooo/focus')
----require('sohooo/spellsitter')

require('tabout').setup()
require('colorizer').setup()
require('nvim_comment').setup()
require('goto-preview').setup{}
require('nvim-autopairs').setup{}

require('sohooo/keymaps')

