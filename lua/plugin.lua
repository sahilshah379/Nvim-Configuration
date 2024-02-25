-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug ('sainnhe/sonokai')
Plug ('nvim-lualine/lualine.nvim')
Plug ('nvim-tree/nvim-web-devicons')
Plug ('nvim-tree/nvim-tree.lua')
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})
Plug ('nvim-lua/plenary.nvim')
Plug ('rmagatti/auto-session')
Plug ('numToStr/Comment.nvim')
Plug ('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
Plug ('akinsho/toggleterm.nvim', {tag = '*'})
Plug ('neoclide/coc.nvim', {branch = 'release'})
Plug ('ggandor/leap.nvim')
-- Plug ('github/copilot.vim')

vim.call('plug#end')


require('lualine').setup({
    options = {
        theme = 'sonokai'
    }
})

require('nvim-tree').setup()

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    }
})

require('auto-session').setup()

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

require('toggleterm').setup({
    open_mapping = '`',
    direction = 'float',
})

require('leap').create_default_mappings()
