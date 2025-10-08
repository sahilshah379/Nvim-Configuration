-- [[ options.lua ]]

-- [[ Context ]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_perl_provider = 0
vim.opt.updatetime = 300
vim.opt.swapfile = false
vim.opt.mouse = 'a'
vim.o.autoread = true

-- [[ Screen ]]
vim.opt.colorcolumn = '80'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.signcolumn = 'no'
vim.opt.wrap = true
vim.opt.winborder = 'rounded'
vim.g.tmux_navigator_no_wrap = 1
vim.cmd('highlight ColorColumn ctermbg=lightgrey guibg=lightgrey')

-- [[ Diagnostics ]]
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    signs = false,
})

-- [[ Filetypes ]]
vim.opt.encoding = 'utf8'
vim.opt.fileencoding = 'utf8'

-- [[ Search ]]
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- [[ Whitespace ]]
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- [[ Splits ]]
vim.opt.splitbelow = true
vim.opt.splitright = true

