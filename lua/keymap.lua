-- [[ keymap.lua ]]

-- [[ Local Variables ]]
local telescope_require = require('telescope.builtin')
local tree_require = require('nvim-tree.api')
local leap_require = require('leap')

-- [[ Clipboard ]]
vim.keymap.set('n', '<leader>y', '"+y', { silent = true })
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { silent = true })
vim.keymap.set('n', '<leader>P', '"+P', { silent = true })

-- [[ VS Code Keybindings ]]
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('v', '<M-k>', ':m \'<-2<CR>gv=gv', { silent = true })
vim.keymap.set('v', '<M-j>', ':m \'>+1<CR>gv=gv', { silent = true })

-- [[ Windows ]]
vim.keymap.set('n', '<C-W>v', ':vnew<CR>', { silent = true })
vim.keymap.set('n', '<C-W><C_V>', ':vnew<CR>', { silent = true })

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

-- [[ Coc ]]
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

function _G.formatter()
    vim.fn.CocActionAsync('format', function()
        vim.api.nvim_command('w')
    end)
end

vim.keymap.set('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
    { silent = true, noremap = true, expr = true, replace_keycodes = false })
vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
    { silent = true, noremap = true, expr = true, replace_keycodes = false })
vim.keymap.set('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    { silent = true, noremap = true, expr = true, replace_keycodes = false })
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.keymap.set('n', '<leader>r', '<Plug>(coc-rename)', { silent = true })
vim.keymap.set('n', '<leader>z', '<CMD>lua _G.formatter()<CR>', { silent = true })
vim.keymap.set('n', 'K', '<CMD>lua _G.show_docs()<CR>', { silent = true })

-- [[ Leap ]]
vim.keymap.set('n', 's', function()
    local focusable_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
    )
    leap_require.leap { target_windows = focusable_windows }
end)
