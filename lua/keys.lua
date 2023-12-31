--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- [[ Clipboard ]]
map('n', '<Leader>y', '"+y', {})
map('v', '<Leader>y', '"+y', {})
map('n', '<Leader>p', '"+p', {})
map('n', '<Leader>P', '"+P', {})

-- [[ VS Code Keybindings ]]
map('n', '<M-Up>', ':m .-2<CR>==', {})
map('n', '<M-Down>', ':m .+1<CR>==', {})
map('v', '<M-Up>', ':m \'<-2<CR>gv=gv', {})
map('v', '<M-Down>', ':m \'>+1<CR>gv=gv', {})

