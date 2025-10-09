-- [[ utility.lua ]]

return {
    {
        'numToStr/Comment.nvim',
        opts = {
            toggler = { line = '<C-_>' },
            opleader = { line = '<C-_>' },
            mappings = { extra = false },
            post_hook = function(ctx)
                if ctx.cmotion == require('Comment.utils').cmotion.v or
                    ctx.cmotion == require('Comment.utils').cmotion.V then
                    vim.cmd('norm! gv')
                end
            end
        }
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').create_default_mappings()
            vim.keymap.set('n', 's', function()
                local focusable_windows = vim.tbl_filter(
                    function(win) return vim.api.nvim_win_get_config(win).focusable end,
                    vim.api.nvim_tabpage_list_wins(0)
                )
                require('leap').leap({ target_windows = focusable_windows })
            end)
        end
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4
            },
            settings = {
                save_on_toggle = true
            }
        },
        keys = {
            { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Harpoon Add' },
            { '<leader>m', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = 'Harpoon Menu' },
            { '<leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon to 1' },
            { '<leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon to 2' },
            { '<leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon to 3' },
            { '<leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon to 4' },
            { '<leader>5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon to 5' },
            { '<leader>6', function() require('harpoon'):list():select(6) end, desc = 'Harpoon to 6' },
            { '<leader>7', function() require('harpoon'):list():select(7) end, desc = 'Harpoon to 7' },
            { '<leader>8', function() require('harpoon'):list():select(8) end, desc = 'Harpoon to 8' },
            { '<leader>9', function() require('harpoon'):list():select(9) end, desc = 'Harpoon to 9' }
        }
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        opts = {
            log_level = 'error',
            auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/'
        }
    },
    {
        'christoomey/vim-tmux-navigator',
        keys = {
            { '<C-h>', '<cmd>TmuxNavigateLeft<cr>' },
            { '<C-j>', '<cmd>TmuxNavigateDown<cr>' },
            { '<C-k>', '<cmd>TmuxNavigateUp<cr>' },
            { '<C-l>', '<cmd>TmuxNavigateRight<cr>' }
        }
    },
    {
        'ojroques/nvim-osc52',
        config = function()
            require('osc52').setup({
                silent = true,
                tmux_passthrough = true
            })
            local function copy(lines, _)
                require('osc52').copy(table.concat(lines, '\n'))
            end
            local function paste()
                return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
            end
            vim.g.clipboard = {
                name = 'osc52',
                copy = { ['+'] = copy, ['*'] = copy },
                paste = { ['+'] = paste, ['*'] = paste }
            }
        end
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            file_types = { 'markdown' }
        }
    }
}

