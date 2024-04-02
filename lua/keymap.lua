-- [[ keymap.lua ]]

-- [[ Local Variables ]]
local telescope_require = require('telescope.builtin')
local tree_require = require('nvim-tree.api')
local leap_require = require('leap')
local harpoon_require = require('harpoon')
local default_opts = { noremap = true, silent = true }
local expression_opts = { expr = true, noremap = true, replace_keycodes = true, silent = true }

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

-- [[ Text Manipulation ]]
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', default_opts)
vim.keymap.set('v', '<M-k>', ':m \'<-2<CR>gv=gv', default_opts)
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', default_opts)
vim.keymap.set('v', '<M-j>', ':m \'>+1<CR>gv=gv', default_opts)
vim.keymap.set('v', '<', '<gv', default_opts)
vim.keymap.set('v', '>', '>gv', default_opts)

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

-- [[ Tree ]]
vim.keymap.set('n', '<leader>t', tree_require.tree.toggle, {})

-- [[ Telescope ]]
vim.keymap.set('n', '<leader>f', telescope_require.find_files, {})
vim.keymap.set('n', '<leader>g', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>h', telescope_require.help_tags, {})

-- [[ Harpoon ]]
vim.keymap.set('n', '<leader>a', function() harpoon_require:list():append() end)
vim.keymap.set('n', '<leader>m', function() harpoon_require.ui:toggle_quick_menu(harpoon_require:list()) end)
vim.keymap.set('n', '<leader>1', function() harpoon_require:list():select(1) end)
vim.keymap.set('n', '<leader>2', function() harpoon_require:list():select(2) end)
vim.keymap.set('n', '<leader>3', function() harpoon_require:list():select(3) end)
vim.keymap.set('n', '<leader>4', function() harpoon_require:list():select(4) end)
vim.keymap.set('n', '<C-n>', function() harpoon_require:list():prev() end)
vim.keymap.set('n', '<C-m>', function() harpoon_require:list():next() end)

-- [[ Coc ]]
-- function _G.check_back_space()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end
--
-- function _G.show_docs()
--     local cw = vim.fn.expand('<cword>')
--     if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
--         vim.api.nvim_command('h ' .. cw)
--     elseif vim.api.nvim_eval('coc#rpc#ready()') then
--         vim.fn.CocActionAsync('doHover')
--     else
--         vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
--     end
-- end
--
-- function _G.formatter()
--     vim.fn.CocActionAsync('format', function()
--         vim.api.nvim_command('w')
--     end)
-- end
--
-- vim.keymap.set('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
--     expression_opts)
-- vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], expression_opts)
-- vim.keymap.set('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
--     expression_opts)
-- vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', default_opts)
-- vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', default_opts)
-- vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', default_opts)
-- vim.keymap.set('n', 'gr', '<Plug>(coc-references)', default_opts)
-- vim.keymap.set('n', '<leader>r', '<Plug>(coc-rename)', default_opts)
-- vim.keymap.set('n', '<leader>z', '<CMD>lua _G.formatter()<CR>', default_opts)
-- vim.keymap.set('n', 'K', '<CMD>lua _G.show_docs()<CR>', default_opts)


-- [[ Leap ]]
vim.keymap.set('n', 's', function()
    local focusable_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
    )
    leap_require.leap { target_windows = focusable_windows }
end)
