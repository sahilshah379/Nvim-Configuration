-- [[ keymap.lua ]]

-- [[ Local Variables ]]
local default_opts = { noremap = true, silent = true }
local lsp_opts = { buffer = bufnr }

-- [[ General ]]
vim.keymap.set('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', default_opts)
vim.keymap.set('n', 'n', 'nzz', default_opts)
vim.keymap.set('n', 'N', 'Nzz', default_opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', default_opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', default_opts)
vim.keymap.set('n', '<C-f>', '<C-f>zz', default_opts)
vim.keymap.set('n', '<C-b>', '<C-b>zz', default_opts)
vim.keymap.set('n', 'gg', 'gg0', default_opts)
vim.keymap.set('n', 'G', 'G$', default_opts)
vim.keymap.set('v', 'gg', 'gg0', default_opts)
vim.keymap.set('v', 'G', 'G$', default_opts)

-- [[ Text Manipulation ]]
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', default_opts)
vim.keymap.set('v', '<M-k>', ':m \'<-2<CR>gv=gv', default_opts)
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', default_opts)
vim.keymap.set('v', '<M-j>', ':m \'>+1<CR>gv=gv', default_opts)
vim.keymap.set('v', '<', '<gv', default_opts)
vim.keymap.set('v', '>', '>gv', default_opts)
vim.keymap.set('i', '<S-Tab>', '<C-d>', default_opts)

-- [[ Clipboard ]]
vim.keymap.set('n', '<leader>y', '"+y', default_opts)
vim.keymap.set('v', '<leader>y', '"+y', default_opts)
vim.keymap.set('n', '<leader>p', '"+p', default_opts)
vim.keymap.set('n', '<leader>P', '"+P', default_opts)
vim.keymap.set('v', '<leader>p', '"+p', default_opts)
vim.keymap.set('v', '<leader>P', '"+P', default_opts)

-- [[ Windows ]]
vim.keymap.set('n', '<C-h>', '<cmd><C-U>TmuxNavigateLeft<CR>', default_opts)
vim.keymap.set('n', '<C-j>', '<cmd><C-U>TmuxNavigateDown<CR>', default_opts)
vim.keymap.set('n', '<C-k>', '<cmd><C-U>TmuxNavigateUp<CR>', default_opts)
vim.keymap.set('n', '<C-l>', '<cmd><C-U>TmuxNavigateRight<CR>', default_opts)
vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', default_opts)
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', default_opts)
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', default_opts)
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', default_opts)

-- [[ Context Commands ]]
vim.keymap.set('n', '<leader>w', ':wa<CR>', {})
vim.keymap.set('n', '<leader>q', ':qa<CR>', {})
vim.keymap.set('n', '<leader>e', ':e!<CR>', {})

-- [[ Telescope ]]
vim.keymap.set('n', '<leader>f', Require.telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>g', ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>')
vim.keymap.set('n', '<leader>d', ':lua require("telescope").extensions.file_browser.file_browser()<CR>')
vim.keymap.set('n', '<leader>h', Require.telescope_builtin.help_tags, {})
Require.telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-h>'] = 'which_key',
                ['<C-q>'] = require('telescope-live-grep-args.actions').quote_prompt(),
                ['<C-f>'] = require('telescope-live-grep-args.actions').quote_prompt({ postfix = ' --iglob ' }),
                ['<C-j>'] = 'move_selection_next',
                ['<Down>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
                ['<Up>'] = 'move_selection_previous',
                ['<C-u>'] = 'preview_scrolling_up',
                ['<C-d>'] = 'preview_scrolling_down',
                ['<CR>'] = 'select_default',
                ['<C-c>'] = 'close',
                ['<C-p>'] = 'nop',
                ['<C-n>'] = 'nop',
                ['<C-x>'] = 'nop',
                ['<C-v>'] = 'nop',
                ['<C-t>'] = 'nop',
                ['<PageUp>'] = 'nop',
                ['<PageDown>'] = 'nop',
                ['<M-f>'] = 'nop',
                ['<M-k>'] = 'nop',
                ['<Tab>'] = 'nop',
                ['<S-Tab>'] = 'nop',
                ['<M-q>'] = 'nop',
                ['<C-l>'] = 'nop',
                ['<C-/>'] = 'nop',
                ['<C-w>'] = 'nop',
                ['<C-r><C-w>'] = 'nop',
                ['<C-r><C-a>'] = 'nop',
                ['<C-r><C-f>'] = 'nop',
                ['<C-r><C-l>'] = 'nop',

            },
            n = {
                ['<C-h>'] = 'which_key',
                ['<C-j>'] = 'move_selection_next',
                ['j'] = 'move_selection_next',
                ['<Down>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
                ['k'] = 'move_selection_previous',
                ['<Up>'] = 'move_selection_previous',
                ['<C-u>'] = 'preview_scrolling_up',
                ['<C-d>'] = 'preview_scrolling_down',
                ['H'] = 'move_to_top',
                ['M'] = 'move_to_middle',
                ['L'] = 'move_to_bottom',
                ['gg'] = 'move_to_top',
                ['G'] = 'move_to_bottom',
                ['<CR>'] = 'select_default',
                ['<esc>'] = 'close',
                ['<C-x>'] = 'nop',
                ['<C-v>'] = 'nop',
                ['<C-t>'] = 'nop',
                ['<Tab>'] = 'nop',
                ['<S-Tab>'] = 'nop',
                ['<C-q>'] = 'nop',
                ['<M-q>'] = 'nop',
                ['<C-f>'] = 'nop',
                ['<PageUp>'] = 'nop',
                ['<PageDown>'] = 'nop',
                ['<M-f>'] = 'nop',
                ['<M-k>'] = 'nop',
                ['?'] = 'nop',
            }
        }
    },
    extensions = {
        file_browser = {
            mappings = {
                ['i'] = {
                    ['<A-c>'] = false,
                    ['<C-n>'] = Require.telescope.extensions.file_browser.actions.create,
                    ['<S-CR>'] = false,
                    ['<CR>'] = 'create_from_prompt',
                    ['<A-r>'] = false,
                    ['<C-r>'] = 'rename',
                    ['<A-m>'] = 'move',
                    ['<A-y>'] = 'copy',
                    ['<A-d>'] = false,
                    ['<C-x>'] = 'remove',
                    ['<C-o>'] = false,
                    ['<C-g>'] = false,
                    ['<C-]>'] = 'goto_parent_dir',
                    ['<C-e>'] = false,
                    ['<C-w>'] = 'goto_cwd',
                    ['<C-t>'] = false,
                    ['<C-f>'] = false,
                    ['<C-h>'] = 'toggle_hidden',
                    ['<C-s>'] = false,
                    ['<bs>'] = 'backspace',
                    [Require.plenary_path.path.sep] = 'path_separator',
                },
                n = {
                    ['c'] = 'create',
                    ['r'] = 'rename',
                    ['m'] = 'move',
                    ['y'] = 'copy',
                    ['d'] = 'remove',
                    ['o'] = false,
                    ['g'] = 'goto_parent_dir',
                    ['<C-]>'] = 'goto_parent_dir',
                    ['e'] = false,
                    ['w'] = 'goto_cwd',
                    ['t'] = false,
                    ['f'] = false,
                    ['h'] = 'toggle_hidden',
                    ['s'] = false,
                }
            }
        }
    }
})

-- [[ Leap ]]
vim.keymap.set('n', 's', function()
    local focusable_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
    )
    Require.leap.leap { target_windows = focusable_windows }
end)

-- [[ Harpoon ]]
vim.keymap.set('n', '<leader>a', function() Require.harpoon:list():add() end)
vim.keymap.set('n', '<leader>m', function() Require.harpoon.ui:toggle_quick_menu(Require.harpoon:list()) end)
vim.keymap.set('n', '<leader>1', function() Require.harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>2', function() Require.harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>3', function() Require.harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>4', function() Require.harpoon:list():select(4) end)
vim.keymap.set('n', '<leader>5', function() Require.harpoon:list():select(5) end)
vim.keymap.set('n', '<leader>6', function() Require.harpoon:list():select(6) end)
vim.keymap.set('n', '<leader>7', function() Require.harpoon:list():select(7) end)
vim.keymap.set('n', '<leader>8', function() Require.harpoon:list():select(8) end)
vim.keymap.set('n', '<leader>9', function() Require.harpoon:list():select(9) end)
vim.keymap.set('n', '<C-n>', function() Require.harpoon:list():prev() end)
vim.keymap.set('n', '<C-m>', function() Require.harpoon:list():next() end)

-- [[ LSP ]]
Require.lsp_zero.on_attach(function(client, bufnr)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, lsp_opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, lsp_opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, lsp_opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, lsp_opts)
    vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end, lsp_opts)
end)

-- [[ Tab Completion ]]
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match('^%s*$') == nil
end
Require.cmp.setup({
    mapping = Require.cmp.mapping.preset.insert({
        -- ['<C-Space>'] = Require.cmp.mapping.confirm {
        --     behavior = Require.cmp.ConfirmBehavior.Insert,
        --     select = true,
        -- },
        ['<Tab>'] = function(fallback)
            if Require.cmp.visible() and has_words_before() then
                if not Require.cmp.select_next_item() then
                    if vim.bo.buftype ~= 'prompt' and has_words_before() then
                        Require.cmp.complete()
                    end
                end
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if Require.cmp.visible() and has_words_before() then
                if not Require.cmp.select_prev_item() then
                    if vim.bo.buftype ~= 'prompt' and has_words_before() then
                        Require.cmp.complete()
                    end
                end
            else
                fallback()
            end
        end,
    }),
})

-- [[ Avante ]]
Require.avante.setup({
    mappings = {
        diff = {
            ours = 'co',
            theirs = 'ct',
            all_theirs = 'ca',
            both = 'cb',
            cursor = 'nop',
            next = ']x',
            prev = '[x',
        },
        suggestion = {
            accept = '<M-l>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
        },
        jump = {
            next = ']]',
            prev = '[[',
        },
        submit = {
            normal = '<CR>',
            insert = '<CR>',
        },
        cancel = {
            normal = { '<C-c>', '<Esc>', 'q' },
            insert = { '<C-c>' },
        },
        ask = '<leader>aa',
        edit = '<leader>ae',
        refresh = 'nop',
        focus = 'nop',
        stop = '<leader>aS',
        toggle = {
            default = '<leader>at',
            debug = '<leader>ad',
            hint = '<leader>ah',
            suggestion = '<leader>as',
            repomap = '<leader>aR',
        },
        sidebar = {
            apply_all = 'A',
            apply_cursor = 'a',
            retry_user_request = 'r',
            edit_user_request = 'e',
            switch_windows = 'nop',
            reverse_switch_windows = 'nop',
            remove_file = 'd',
            add_file = 'a',
            close = { },
            close_from_input = nil,
        },
    },
})
