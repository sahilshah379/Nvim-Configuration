-- [[ treesitter.lua ]]

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
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
            require('nvim-treesitter.configs').setup(opts)
        end
    }
}

