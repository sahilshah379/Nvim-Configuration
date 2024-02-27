-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug ('sainnhe/sonokai') -- theme
Plug ('nvim-lualine/lualine.nvim') -- statusline
Plug ('nvim-tree/nvim-web-devicons') -- icons
Plug ('nvim-tree/nvim-tree.lua') -- file explorer
Plug ('nvim-lua/plenary.nvim') -- dependency for telescope
Plug ('nvim-telescope/telescope.nvim', { branch = '0.1.x' }) -- fuzzy finder
Plug ('akinsho/toggleterm.nvim', {tag = '*'}) -- terminal
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'}) -- highlighting
Plug ('numToStr/Comment.nvim') -- toggle comment
Plug ('ggandor/leap.nvim') -- jump to phrase
Plug ('neoclide/coc.nvim', {branch = 'release'}) -- code auto complete
Plug ('rmagatti/auto-session') -- session manager (~/.local/share/nvim/sessions)

vim.call('plug#end')


require('lualine').setup {
  options = {
    theme = 'sonokai',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

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
