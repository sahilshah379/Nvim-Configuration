-- [[ cmp.lua ]]

return {
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'zbirenbaum/copilot-cmp',
            'onsails/lspkind.nvim'
        },
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            require('copilot_cmp').setup()

            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
            end
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() and has_words_before() then
                            if not cmp.select_next_item() then
                                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                                    cmp.complete()
                                end
                            end
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() and has_words_before() then
                            if not cmp.select_prev_item() then
                                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                                    cmp.complete()
                                end
                            end
                        else
                            fallback()
                        end
                    end, { 'i', 's' })
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        symbol_map = { Copilot = '' },
                        ellipsis_char = '...',
                        show_labelDetails = true
                    })
                },
                sources = cmp.config.sources({
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'cmdline' }
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                }
            })
        end
    },
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup({
                auto_attach = true,
                suggestion = { enabled = false },
                panel = { enabled = false }
            })
        end
    },
    {
        'mason-org/mason.nvim',
        config = function()
            require('mason').setup()
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'nvim-telescope/telescope.nvim'
        },
        config = function()
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false, silent = true }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end, opts)
                vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references({ reuse_win = true }) end, opts)
                vim.keymap.set('n', 'gI', function() require('telescope.builtin').lsp_implementations({ reuse_win = true }) end, opts)
                vim.keymap.set('n', 'gy', function() require('telescope.builtin').lsp_type_definitions({ reuse_win = true }) end, opts)
            end
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup({
                ensure_installed = { 'bashls', 'clangd', 'lua_ls', 'pyright' },
                handlers = {
                    function(server_name)
                        vim.lsp.config(server_name, {
                            on_attach = on_attach,
                            capabilities = capabilities
                        })
                    end
                }
            })
        end
    }
}

