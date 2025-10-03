-- [[ plugin.lua ]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim')                                              -- theme
Plug('nvim-lualine/lualine.nvim')                                    -- statusline
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })     -- highlighting
Plug('nvim-lua/plenary.nvim')                                        -- dependency
Plug('MunifTanjim/nui.nvim')                                         -- UI dependency
Plug('stevearc/dressing.nvim')                                       -- UI dependency
Plug('nvim-tree/nvim-web-devicons')                                  -- icons
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })      -- fuzzy finder
Plug('nvim-telescope/telescope-live-grep-args.nvim')                 -- telescope grep
Plug('nvim-telescope/telescope-file-browser.nvim')                   -- telescope directory
Plug('numToStr/Comment.nvim')                                        -- toggle comment
Plug('ggandor/leap.nvim')                                            -- jump to phrase
Plug('ThePrimeagen/harpoon', { ['branch'] = 'harpoon2' })            -- marks
Plug('rmagatti/auto-session')                                        -- session manager
Plug('christoomey/vim-tmux-navigator')                               -- tmux movement
Plug('ojroques/nvim-osc52')                                          -- ansi osc52
Plug('neovim/nvim-lspconfig')                                        -- lsp config
Plug('williamboman/mason.nvim')                                      -- lsp installer
Plug('williamboman/mason-lspconfig.nvim')                            -- mason & lspconfig
Plug('VonHeikemen/lsp-zero.nvim', { ['branch'] = 'v3.x' })           -- lsp quickstart
Plug('zbirenbaum/copilot.lua')                                       -- github copilot
Plug('hrsh7th/nvim-cmp')                                             -- completion
Plug('onsails/lspkind.nvim')                                         -- cmp icons
Plug('zbirenbaum/copilot-cmp')                                       -- cmp from copilot
Plug('hrsh7th/cmp-nvim-lsp')                                         -- cmp from lsp
Plug('hrsh7th/cmp-buffer')                                           -- cmp from buffer
Plug('hrsh7th/cmp-path')                                             -- cmp from path
Plug('hrsh7th/cmp-cmdline')                                          -- cmp from cmd
Plug('windwp/nvim-autopairs')                                        -- autopairs
Plug('MeanderingProgrammer/render-markdown.nvim')                    -- markdown render
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
Require.osc52 = require('osc52')
Require.mason = require('mason')
Require.mason_lspconfig = require('mason-lspconfig')
Require.lsp_zero = require('lsp-zero')
Require.copilot = require('copilot')
Require.cmp = require('cmp')
Require.lspkind = require('lspkind')
Require.copilot_cmp = require('copilot_cmp')
Require.copilot_cmp_comparators = require('copilot_cmp.comparators')
Require.autopairs = require('nvim-autopairs')
Require.autopairs_cmp = require('nvim-autopairs.completion.cmp')
Require.render_markdown = require('render-markdown')
Require.avante = require('avante')
Require.avante_api = require('avante.api')
Require.avante_config = require('avante.config')
Require.avante_diff = require('avante.diff')

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
        'bash', 'c', 'comment', 'cpp', 'r', 'java', 'javascript', 'lua', 'markdown', 'markdown_inline', 'python', 'tmux', 'yaml'
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

Require.osc52.setup({
    silent = true,
    tmux_passthrough = true
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

Require.copilot.setup({
    auto_attach = true,
    suggestion = { enabled = false },
    panel = { enabled = false },
})

Require.cmp.setup({
    formatting = {
        format = Require.lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = {
                menu = 50,
                abbr = 50,
            },
            symbol_map = { Copilot = '' },
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function (entry, vim_item)
                return vim_item
            end
        })
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            Require.copilot_cmp_comparators.prioritize,
            Require.cmp.config.compare.offset,
            Require.cmp.config.compare.exact,
            Require.cmp.config.compare.score,
            Require.cmp.config.compare.recently_used,
            Require.cmp.config.compare.locality,
            Require.cmp.config.compare.kind,
            Require.cmp.config.compare.sort_text,
            Require.cmp.config.compare.length,
            Require.cmp.config.compare.order,
        },
    },
    sources = {
        { name = 'copilot', group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'buffer' , group_index = 2 },
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

Require.copilot_cmp.setup()

Require.autopairs.setup()
Require.cmp.event:on(
    'confirm_done',
    Require.autopairs_cmp.on_confirm_done({
        filetypes = { markdown = false, text = false, ['*'] = {} }
    })
)

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
    providers = {
        openai = {
            endpoint = 'https://api.openai.com/v1',
            model = 'gpt-4o',
            extra_request_body = {
                temperature = 0.5,
                max_completion_tokens = 16384,
            },
        },
    },
})

