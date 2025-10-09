-- [[ telescope.lua ]]

return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            'nvim-telescope/telescope-file-browser.nvim'
        },
        keys = {
            { '<leader>f', '<cmd>Telescope find_files<cr>' },
            { '<leader>g', '<cmd>Telescope live_grep_args<cr>' },
            { '<leader>d', '<cmd>Telescope file_browser<cr>' }
        },
        opts = function()
            return {
                defaults = {
                    file_ignore_patterns = { '__pycache__/', '.git/', '.venv/' },
                },
                pickers = {
                    find_files = {
                        find_command = { 'rg', '--files', '--color', 'never', '-g', '!.git' }
                    }
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ['<C-q>'] = require('telescope-live-grep-args.actions').quote_prompt(),
                                ['<C-f>'] = require('telescope-live-grep-args.actions').quote_prompt({ postfix = ' --iglob ' })
                            }
                        }
                    },
                    file_browser = {}
                }
            }
        end,
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            telescope.load_extension('live_grep_args')
            telescope.load_extension('file_browser')
        end
    }
}

