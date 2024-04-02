-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim')                                          -- theme
Plug('nvim-lualine/lualine.nvim')                                -- statusline
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' }) -- highlighting
Plug('nvim-lua/plenary.nvim')                                    -- dependency
Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })      -- fuzzy finder
Plug('nvim-telescope/telescope-live-grep-args.nvim')             -- grep config
Plug('numToStr/Comment.nvim')                                    -- toggle comment
Plug('ggandor/leap.nvim')                                        -- jump to phrase
Plug('ThePrimeagen/harpoon', { branch = 'harpoon2' })            -- marks
Plug('rmagatti/auto-session')                                    -- session manager
Plug('christoomey/vim-tmux-navigator')                           -- tmux movement
Plug('neovim/nvim-lspconfig')                                    -- lsp config
Plug('williamboman/mason.nvim')                                  -- lsp installer
Plug('williamboman/mason-lspconfig.nvim')                        -- mason & lspconfig
Plug('hrsh7th/nvim-cmp')                                         -- completion
Plug('hrsh7th/cmp-nvim-lsp')                                     -- completion lsp
Plug('hrsh7th/cmp-buffer')                                       -- lsp from buffer
Plug('VonHeikemen/lsp-zero.nvim', { branch = 'v3.x' })           -- lsp quickstart

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

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash', 'c', 'comment', 'cpp', 'java', 'javascript', 'lua', 'python', 'tmux', 'yaml'
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
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
        mappings = {
            i = {
                ['<C-h>'] = 'which_key',
                ['<C-q>'] = require('telescope-live-grep-args.actions').quote_prompt(),
                ['<C-f>'] = require('telescope-live-grep-args.actions').quote_prompt({ postfix = ' --iglob ' }),
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',

            },
            n = {
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
            }
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

require('harpoon').setup()

require('auto-session').setup({
    log_level = 'error',
    auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
    post_restore_cmds = {
        function()
            local windows = vim.api.nvim_list_wins()
            for _, win in ipairs(windows) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_name = vim.api.nvim_buf_get_name(buf)
                if buf_name:find('NvimTree_1') then
                    vim.cmd('NvimTreeToggle')
                    return
                end
            end
        end
    },
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'bashls', 'clangd', 'lua_ls', 'pyright'
    },
    handlers = {
        require('lsp-zero').default_setup,
    },
})
require('cmp').setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
})
require('lsp-zero').set_server_config({
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
