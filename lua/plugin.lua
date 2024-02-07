-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug ('numToStr/Comment.nvim')
Plug ('nvim-tree/nvim-web-devicons')
Plug ('nvim-tree/nvim-tree.lua')
Plug ('nvim-lua/plenary.nvim')
Plug ('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
Plug ('akinsho/toggleterm.nvim', {tag = '*'})
Plug ('neoclide/coc.nvim', {branch = 'release'})
Plug ('rmagatti/auto-session')
Plug ('ggandor/leap.nvim')
Plug ('github/copilot.vim')

vim.call('plug#end')


require('Comment').setup({
    toggler = {
        line = '<C-_>',
        block = nil,
    },
    opleader = {
        line = '<C-_>',
        block = nil,
    },
    mappings = {
        extra = false,
    },
    post_hook = function(ctx)
        if ctx.cmotion == require('Comment.utils').cmotion.v or 
           ctx.cmotion == require('Comment.utils').cmotion.V then
            vim.cmd('norm! gv')
        end
    end,
})

require('nvim-tree').setup()

require('toggleterm').setup({
    open_mapping = '`',
    direction = 'float',
})

require("auto-session").setup()

require('leap').create_default_mappings()
