-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim')                                          -- theme
Plug('nvim-lualine/lualine.nvim')                                -- statusline
Plug('nvim-tree/nvim-web-devicons')                              -- icons
Plug('nvim-tree/nvim-tree.lua')                                  -- file explorer
Plug('nvim-lua/plenary.nvim')                                    -- dependency for telescope
Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })      -- fuzzy finder
Plug('nvim-telescope/telescope-live-grep-args.nvim')             -- grep config
Plug('akinsho/toggleterm.nvim', { tag = '*' })                   -- terminal
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' }) -- highlighting
Plug('numToStr/Comment.nvim')                                    -- toggle comment
Plug('ggandor/leap.nvim')                                        -- jump to phrase
Plug('neoclide/coc.nvim', { branch = 'release' })                -- code auto complete
Plug('rmagatti/auto-session')                                    -- session manager (~/.local/share/nvim/sessions)
Plug('christoomey/vim-tmux-navigator')                           -- tmux

vim.call('plug#end')


require('lualine').setup({
    options = {
        theme = 'catppuccin',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})

require('nvim-tree').setup()

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
})

require('telescope').load_extension('live_grep_args')
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '__pycache__/',
            '.git/',
            '.venv/'
        },
    },
    pickers = {
        find_files = {
            find_command = { 'rg', '--files', '--hidden' },
        },
    },
    extensions = {
        live_grep_args = {
            auto_quoting = true,
        },
    },
})

require('toggleterm').setup({
    open_mapping = '`',
    direction = 'float',
})

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

require('leap').create_default_mappings()

require('auto-session').setup()
