-- [[ treesitter.lua ]]

return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'bash', 'c', 'comment', 'cpp', 'java', 'json', 'lua',
                'markdown', 'markdown_inline', 'python', 'tmux', 'yaml'
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            indent = {
                enable = true
            }
        },
        config = function(_, opts)
            require('nvim-treesitter').setup(opts)
        end
    }
}

