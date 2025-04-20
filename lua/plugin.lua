-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim')                                              -- theme
Plug('nvim-lualine/lualine.nvim')                                    -- statusline
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })     -- highlighting
Plug('nvim-lua/plenary.nvim')                                        -- dependency
Plug('MunifTanjim/nui.nvim')                                         -- UI dependency
Plug('stevearc/dressing.nvim')                                       -- UI dependency
Plug('nvim-tree/nvim-web-devicons')                                  -- Icons
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })      -- fuzzy finder
Plug('nvim-telescope/telescope-live-grep-args.nvim')                 -- telescope grep
Plug('nvim-telescope/telescope-file-browser.nvim')                   -- telescope directory
Plug('numToStr/Comment.nvim')                                        -- toggle comment
Plug('ggandor/leap.nvim')                                            -- jump to phrase
Plug('ThePrimeagen/harpoon', { ['branch'] = 'harpoon2' })            -- marks
Plug('rmagatti/auto-session')                                        -- session manager
Plug('christoomey/vim-tmux-navigator')                               -- tmux movement
Plug('neovim/nvim-lspconfig')                                        -- lsp config
Plug('williamboman/mason.nvim')                                      -- lsp installer
Plug('williamboman/mason-lspconfig.nvim')                            -- mason & lspconfig
Plug('VonHeikemen/lsp-zero.nvim', { ['branch'] = 'v3.x' })           -- lsp quickstart
Plug('hrsh7th/nvim-cmp')                                             -- completion
Plug('onsails/lspkind.nvim')                                         -- cmp icons
Plug('hrsh7th/cmp-nvim-lsp')                                         -- cmp from lsp
Plug('hrsh7th/cmp-buffer')                                           -- cmp from buffer
Plug('hrsh7th/cmp-path')                                             -- cmp from path
Plug('hrsh7th/cmp-cmdline')                                          -- cmp from cmd
Plug('MeanderingProgrammer/render-markdown.nvim')                    -- .md render
Plug('yetone/avante.nvim', { ['branch'] = 'main', ['do'] = 'make' }) -- avante

vim.call('plug#end')

Require = {}
Require.catppuccin = require('catppuccin')
Require.lualine = require('lualine')
Require.treesitter = require('nvim-treesitter.configs')
Require.plenary_path = require('plenary.path')
Require.telescope = require('telescope')
Require.telescope_builtin = require('telescope.builtin')
Require.comment = require('Comment')
Require.comment_utils = require('Comment.utils')
Require.leap = require('leap')
Require.harpoon = require('harpoon')
Require.auto_session = require('auto-session')
Require.mason = require('mason')
Require.mason_lspconfig = require('mason-lspconfig')
Require.lsp_zero = require('lsp-zero')
Require.cmp = require('cmp')
Require.lspkind = require('lspkind')
Require.render_markdown = require('render-markdown')
Require.avante = require('avante')
Require.avante_config = require('avante.config')

Require.catppuccin.setup({
    flavour = 'mocha',
})
vim.cmd('colorscheme catppuccin')

Require.lualine.setup({
    options = {
        theme = 'catppuccin',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', file_status = true, path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})

Require.treesitter.setup({
    ensure_installed = {
        'bash', 'c', 'comment', 'cpp', 'java', 'javascript', 'lua', 'markdown', 'markdown_inline', 'python', 'tmux', 'yaml'
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

Require.telescope.load_extension('live_grep_args')
Require.telescope.load_extension('file_browser')
Require.telescope.setup({
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

Require.comment.setup({
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
        if ctx.cmotion == Require.comment_utils.cmotion.v or
            ctx.cmotion == Require.comment_utils.cmotion.V then
            vim.cmd('norm! gv')
        end
    end,
})

Require.leap.create_default_mappings()

Require.harpoon.setup()

Require.auto_session.setup({
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

Require.mason.setup()
Require.mason_lspconfig.setup({
    ensure_installed = {
        'bashls', 'clangd', 'lua_ls', 'pyright'
    },
    handlers = {
        Require.lsp_zero.default_setup,
    },
})

Require.lsp_zero.set_server_config({
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

Require.cmp.setup({
    formatting = {
        format = Require.lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = {
                menu = 50,
                abbr = 50,
            },
            -- symbol_map = { Copilot = '' },
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function (entry, vim_item)
                return vim_item
            end
        })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    window = {
        completion = Require.cmp.config.window.bordered(),
        documentation = Require.cmp.config.window.bordered()
    }
})
Require.cmp.setup.cmdline({ '/', '?' }, {
    mapping = Require.cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
Require.cmp.setup.cmdline(':', {
    mapping = Require.cmp.mapping.preset.cmdline(),
    sources = Require.cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

Require.render_markdown.setup({
    file_types = {
        'markdown',
        'Avante',
    },
})

Require.avante.setup({
    provider = 'openai',
    auto_suggestions_provider = nil,
    cursor_applying_provider = nil,
    openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o',
        timeout = 30000,
        temperature = 0,
        max_tokens = 16384,
        -- reasoning_effort='medium'
    },
    dual_boost = {
        enabled = false,
    },
    behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
        minimize_diff = true,
        enable_token_counting = true,
        enable_cursor_planning_mode = false,
        enable_claude_text_editor_tool_mode = false,
    },
    hints = { enabled = false },
    windows = {
        position = 'right',
        wrap = true,
        width = 30,
        sidebar_header = {
            enabled = true,
            align = 'center',
            rounded = true,
        },
        input = {
            prefix = '> ',
            height = 8,
        },
        edit = {
            border = 'rounded',
            start_insert = true,
        },
        ask = {
            floating = false,
            start_insert = false,
            border = 'rounded',
            focus_on_apply = 'ours',
        },
    },
    highlights = {
        diff = {
            current = 'DiffText',
            incoming = 'DiffAdd',
        },
    },
    avante = {
        background = 'Normal',
        border = 'FloatBorder',
        text = 'Normal',
        prompt = 'Normal',
        hint = 'Comment',
    },
    diff = {
        autojump = true,
        list_opener = 'copen',
        override_timeoutlen = 500,
    },
    suggestion = {
        debounce = 600,
        throttle = 600,
    }
})

