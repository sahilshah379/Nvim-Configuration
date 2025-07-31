-- [[ keymap.lua ]]

-- [[ Local Variables ]]
local default_opts = { noremap = true, silent = true }

-- [[ General ]]
vim.keymap.set('n', '<ESC>', function()
    vim.cmd('nohlsearch')
    vim.cmd('echo')
end, default_opts)
vim.keymap.set('n', 'n', 'nzz', default_opts)
vim.keymap.set('n', 'N', 'Nzz', default_opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', default_opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', default_opts)
vim.keymap.set('n', '<C-f>', '<C-f>zz', default_opts)
vim.keymap.set('n', '<C-b>', '<C-b>zz', default_opts)
vim.keymap.set({'n', 'x'}, 'gg', 'gg0', default_opts)
vim.keymap.set({'n', 'x'}, 'G', 'G$', default_opts)

-- [[ Text Manipulation ]]
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', default_opts)
vim.keymap.set('x', '<M-k>', ':m \'<-2<CR>gv=gv', default_opts)
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', default_opts)
vim.keymap.set('x', '<M-j>', ':m \'>+1<CR>gv=gv', default_opts)
vim.keymap.set('x', '<', '<gv', default_opts)
vim.keymap.set('x', '>', '>gv', default_opts)
vim.keymap.set('i', '<S-Tab>', '<C-d>', default_opts)
vim.keymap.set("n", "<leader>j", function() if vim.bo.filetype == "json" or vim.bo.filetype == "jsonl" then vim.cmd("%!jq .") end end, { desc = "Format JSON/JSONL with jq" })

-- [[ Clipboard ]]
vim.keymap.set('n', '<leader>y', '"+y', default_opts)
vim.keymap.set('x', '<leader>y', '"+y', default_opts)
vim.keymap.set('x', 'p', '"_dP', default_opts)

-- [[ Windows ]]
vim.keymap.set('n', '<C-h>', function() vim.cmd('TmuxNavigateLeft') end, default_opts)
vim.keymap.set('n', '<C-j>', function() vim.cmd('TmuxNavigateDown') end, default_opts)
vim.keymap.set('n', '<C-k>', function() vim.cmd('TmuxNavigateUp') end, default_opts)
vim.keymap.set('n', '<C-l>', function() vim.cmd('TmuxNavigateRight') end, default_opts)
vim.keymap.set('n', '<M-Up>',    function() vim.cmd('resize +2') end, default_opts)
vim.keymap.set('n', '<M-Down>',  function() vim.cmd('resize -2') end, default_opts)
vim.keymap.set('n', '<M-Left>',  function() vim.cmd('vertical resize -2') end, default_opts)
vim.keymap.set('n', '<M-Right>', function() vim.cmd('vertical resize +2') end, default_opts)

-- [[ Context Commands ]]
vim.keymap.set('n', '<leader>w', function() vim.cmd('wa') end, default_opts)
vim.keymap.set('n', '<leader>q', function() vim.cmd('qa') end, default_opts)
vim.keymap.set('n', '<leader>e', function() vim.cmd('e!') end, default_opts)
vim.keymap.set('n', '<leader>h', vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>l", function() local is_relative = vim.wo.relativenumber vim.wo.relativenumber = not is_relative end, default_opts)

-- [[ Telescope ]]
vim.keymap.set('n', '<leader>f', Require.telescope_builtin.find_files, default_opts)
vim.keymap.set('n', '<leader>g', function() Require.telescope.extensions.live_grep_args.live_grep_args() end, default_opts)
vim.keymap.set('n', '<leader>d', function() Require.telescope.extensions.file_browser.file_browser() end, default_opts)
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
                    ['<S-CR>'] = false,
                    ['<A-r>'] = false,
                    ['<A-m>'] = false,
                    ['<A-y>'] = false,
                    ['<A-d>'] = false,
                    ['<C-o>'] = false,
                    ['<C-g>'] = false,
                    ['<C-e>'] = false,
                    ['<C-w>'] = false,
                    ['<C-t>'] = false,
                    ['<C-f>'] = false,
                    ['<C-h>'] = false,
                    ['<C-s>'] = false,
                    ['<bs>'] = false,
                    [Require.plenary_path.path.sep] = false,
                },
                n = {
                    ['c'] = Require.telescope.extensions.file_browser.actions.create,
                    ['r'] = Require.telescope.extensions.file_browser.actions.rename,
                    ['m'] = Require.telescope.extensions.file_browser.actions.move,
                    ['y'] = Require.telescope.extensions.file_browser.actions.copy,
                    ['d'] = Require.telescope.extensions.file_browser.actions.remove,
                    ['o'] = false,
                    ['p'] = Require.telescope.extensions.file_browser.actions.goto_parent_dir,
                    ['e'] = false,
                    ['w'] = Require.telescope.extensions.file_browser.actions.goto_cwd,
                    ['t'] = false,
                    ['f'] = false,
                    ['h'] = Require.telescope.extensions.file_browser.actions.toggle_hidden,
                    ['s'] = false,
                }
            }
        }
    }
})
Require.telescope.load_extension('file_browser')

-- [[ Leap ]]
vim.keymap.set('n', 's', function()
    local focusable_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
    )
    Require.leap.leap { target_windows = focusable_windows }
end)

-- [[ Harpoon ]]
vim.keymap.set('n', '<leader>s', function() Require.harpoon:list():add() end)
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

-- [[ LSP ]]
Require.lsp_zero.on_attach(function(client, bufnr)
    local lsp_opts = { buffer = bufnr }
    vim.keymap.set({'n', 'x'}, 'K', function() vim.lsp.buf.hover() end, lsp_opts)
    vim.keymap.set({'n', 'x'}, 'gd', Require.telescope_builtin.lsp_definitions, lsp_opts)
    vim.keymap.set({'n', 'x'}, 'gr', Require.telescope_builtin.lsp_references, lsp_opts)
    vim.keymap.set({'n', 'x'}, '<leader>r', function() vim.lsp.buf.rename() end, lsp_opts)
end)

-- [[ Tab Completion ]]
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match('^%s*$') == nil
end
Require.cmp.setup({
    mapping = Require.cmp.mapping.preset.insert({
        ['<C-Space>'] = Require.cmp.mapping.confirm {
            behavior = Require.cmp.ConfirmBehavior.Insert,
            select = true,
        },
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

