-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Keep leader settings visible here even though init.lua also sets them before
-- lazy.nvim bootstrap. LazyVim's defaults load before this file.
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local term = (vim.env.TERM or ""):lower()
local term_program = (vim.env.TERM_PROGRAM or ""):lower()
local disable_osc52 = vim.env.NVIM_DISABLE_OSC52 == "1"
  or term:find("putty", 1, true) ~= nil
  or term_program:find("putty", 1, true) ~= nil

if disable_osc52 then
  vim.g.termfeatures = vim.tbl_deep_extend("force", vim.g.termfeatures or {}, {
    osc52 = false,
  })
end

local opt = vim.opt

opt.inccommand = "split" -- show substitution previews in a split
opt.hlsearch = true -- highlight search matches
opt.incsearch = true -- show matches while typing
opt.showmatch = true -- briefly jump to matching brackets
opt.matchtime = 2 -- tenths of a second for showmatch
opt.scrolloff = 8 -- keep context around the cursor
opt.mouse = "" -- keyboard-first workflow
opt.wrap = true -- wrap long lines by default
opt.breakindent = true -- preserve indentation on wrapped lines
opt.timeout = true -- wait for mapped key sequences
opt.timeoutlen = 400 -- old config used a slightly longer which-key timeout
opt.signcolumn = "yes:2" -- keep a stable sign area when diagnostics/git markers appear
opt.numberwidth = 4 -- keep line-number width stable across focus changes
opt.statuscolumn = "%s%=%l " -- fixed signs plus right-aligned line numbers
opt.iskeyword:append("-") -- treat dashed words as one word
