-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Keep leader settings visible here even though init.lua also sets them before
-- lazy.nvim bootstrap. LazyVim's defaults load before this file.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

opt.inccommand = "split" -- show substitution previews in a split
opt.hlsearch = true -- highlight search matches
opt.incsearch = true -- show matches while typing
opt.showmatch = true -- briefly jump to matching brackets
opt.matchtime = 2 -- tenths of a second for showmatch
opt.scrolloff = 8 -- keep context around the cursor
opt.mouse = "" -- keyboard-first workflow
opt.breakindent = true -- preserve indentation on wrapped lines
opt.timeout = true -- wait for mapped key sequences
opt.timeoutlen = 400 -- old config used a slightly longer which-key timeout
opt.signcolumn = "yes:1" -- keep a stable single sign column
opt.iskeyword:append("-") -- treat dashed words as one word
