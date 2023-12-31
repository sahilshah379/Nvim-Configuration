-- [[ keymap.lua ]]

-- [[ Local Variables ]]
local map = vim.api.nvim_set_keymap
local telescope_builtin = require('telescope.builtin')
local tree_api = require('nvim-tree.api')

-- [[ Clipboard ]]
map('n', '<leader>y', '"+y', {})
map('v', '<leader>y', '"+y', {})
map('n', '<leader>p', '"+p', {})
map('n', '<leader>P', '"+P', {})

-- [[ VS Code Keybindings ]]
map('n', '<M-Up>', ':m .-2<CR>==', {})
map('n', '<M-Down>', ':m .+1<CR>==', {})
map('v', '<M-Up>', ':m \'<-2<CR>gv=gv', {})
map('v', '<M-Down>', ':m \'>+1<CR>gv=gv', {})

-- [[ Tree ]]
vim.keymap.set('n', '<leader>e', tree_api.tree.toggle, {})

-- [[ Telescope ]]
vim.keymap.set('n', '<leader>f', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>g', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>h', telescope_builtin.help_tags, {})

-- [[ Coc ]]
vim.opt.updatetime = 300
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.keymap.set('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
vim.keymap.set('n', 'K', '<CMD>lua _G.show_docs()<CR>', {silent = true})
