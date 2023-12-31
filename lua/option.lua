-- [[ options.lua ]]

-- [[ Local Variables ]]
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

-- [[ Context ]]
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- [[ Screen ]]
opt.colorcolumn = '80'
cmd('highlight ColorColumn ctermbg=lightgrey guibg=lightgrey')
opt.number = true
opt.relativenumber = true
opt.scrolloff = 2
opt.wrap = true
opt.signcolumn = 'no'
opt.mouse = nil

-- [[ Filetypes ]]
opt.encoding = 'utf8'
opt.fileencoding = 'utf8'

-- [[ Theme ]]
opt.syntax = 'ON'
opt.termguicolors = true

-- [[ Search ]]
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- [[ Whitespace ]]
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

-- [[ Splits ]]
opt.splitbelow = true
opt.splitright = true
