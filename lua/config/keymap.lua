-- [[ keymap.lua ]]

local opts = { noremap = true, silent = true }

-- [[ General ]]
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR><cmd>echo<CR>', opts)
vim.keymap.set('n', 'n', 'nzz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-f>', '<C-f>zz', opts)
vim.keymap.set('n', '<C-b>', '<C-b>zz', opts)
vim.keymap.set({ 'n', 'x' }, 'gg', 'gg0', opts)
vim.keymap.set({ 'n', 'x' }, 'G', 'G$', opts)

-- [[ Text Manipulation ]]
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', opts)
vim.keymap.set('x', '<M-k>', ':m \'<-2<CR>gv=gv', opts)
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', opts)
vim.keymap.set('x', '<M-j>', ':m \'>+1<CR>gv=gv', opts)
vim.keymap.set('x', '<', '<gv', opts)
vim.keymap.set('x', '>', '>gv', opts)
vim.keymap.set('i', '<S-Tab>', '<C-d>', opts)
vim.keymap.set('n', '<leader>j', function()
    if vim.bo.filetype == 'json' or vim.bo.filetype == 'jsonl' then
        vim.cmd('%!jq .')
        vim.cmd('set syntax=json')
    end
end, opts)

-- [[ Clipboard ]]
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', opts)
vim.keymap.set('x', 'p', '"_dP', opts)

-- [[ Windows ]]
vim.keymap.set('n', '<M-Up>', function() vim.cmd('resize +2') end, opts)
vim.keymap.set('n', '<M-Down>', function() vim.cmd('resize -2') end, opts)
vim.keymap.set('n', '<M-Left>', function() vim.cmd('vertical resize -2') end, opts)
vim.keymap.set('n', '<M-Right>', function() vim.cmd('vertical resize +2') end, opts)

-- [[ Context Commands ]]
vim.keymap.set('n', '<leader>w', '<cmd>wa<cr>', opts)
vim.keymap.set('n', '<leader>q', '<cmd>qa<cr>', opts)
vim.keymap.set('n', '<leader>e', '<cmd>e!<cr>', opts)
vim.keymap.set('n', '<leader>l', function() vim.wo.relativenumber = not vim.wo.relativenumber end, opts)

-- [[ Terminal ]]
local Terminal = {
    window = nil, bufnr = nil, job_id = nil,
    close = function(self)
        if self.window and vim.api.nvim_win_is_valid(self.window) then
            vim.api.nvim_win_close(self.window, true)
            vim.cmd('stopinsert!')
        end
    end,
    spawn = function(self)
        self.job_id = vim.fn.termopen(vim.o.shell, {
            detach = 1,
            on_exit = function()
                self:close()
                if self.bufnr and vim.api.nvim_buf_is_loaded(self.bufnr) then
                    vim.api.nvim_buf_delete(self.bufnr, { force = true })
                end
                self.window, self.bufnr, self.job_id = nil, nil, nil
            end,
        })
        vim.api.nvim_buf_set_keymap(self.bufnr, 't', '<C-h>', '<C-h>', opts)
        vim.api.nvim_buf_set_keymap(self.bufnr, 't', '<C-j>', '<C-j>', opts)
        vim.api.nvim_buf_set_keymap(self.bufnr, 't', '<C-k>', '<C-k>', opts)
        vim.api.nvim_buf_set_keymap(self.bufnr, 't', '<C-l>', '<C-l>', opts)
        vim.api.nvim_buf_set_keymap(self.bufnr, 't', '<M-j>', '', opts)
        vim.api.nvim_buf_set_keymap(self.bufnr, 't', '<M-k>', '', opts)
    end,
    open = function(self)
        local should_spawn = not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr)
        if should_spawn then self.bufnr = vim.api.nvim_create_buf(false, false) end

        local width, height = math.ceil(vim.o.columns * 0.8), math.ceil(vim.o.lines * 0.8)
        self.window = vim.api.nvim_open_win(self.bufnr, true, {
            relative = 'editor', style = 'minimal', border = 'rounded', width = width, height = height,
            row = math.ceil((vim.o.lines - height) / 2), col = math.ceil((vim.o.columns - width) / 2)
        })
        if should_spawn then self:spawn() end
        vim.api.nvim_set_current_win(self.window)
        vim.cmd('startinsert')
        vim.api.nvim_create_autocmd('WinLeave', { buffer = self.bufnr, callback = function() self:close() end })
    end,
    toggle = function(self)
        if self.window and vim.api.nvim_win_is_valid(self.window) then self:close() else self:open() end
    end
}
vim.keymap.set({ 'n', 't' }, '`', function() Terminal:toggle() end, opts)
vim.api.nvim_create_autocmd('UIEnter', {
    pattern = '*',
    callback = function()
        vim.schedule(function()
            Terminal:toggle()
            vim.fn.chansend(Terminal.job_id, 'if type conda | grep -q "function" && [ -d "$(conda info --base)/envs/dev" ]; then conda activate dev; fi\n')
            vim.fn.chansend(Terminal.job_id, '(clear && claude --continue 2>/dev/null) || (clear && claude)\n')
            Terminal:toggle()
        end)
    end,
})

-- [[ Translation ]]
vim.keymap.set({ 'n', 'x' }, '<leader>t', function()
    local mode = vim.fn.mode()
    local s_row, s_col, e_row, e_col

    if mode == 'v' or mode == 'V' then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
        s_row, s_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
        e_row, e_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))
        if mode == 'V' then s_col, e_col = 0, vim.fn.col({ e_row, '$' }) - 2 end
    else
        s_row, e_row = vim.fn.line('.'), vim.fn.line('.')
        local _, sc, ec = unpack(vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. vim.fn.col('.') .. 'c\\k*'))
        s_col, e_col = sc, ec - 1
    end

    local lines = vim.api.nvim_buf_get_text(0, s_row - 1, s_col, e_row - 1, e_col + 1, {})
    if #lines == 0 or (#lines == 1 and lines[1] == '') then return end

    local encode = function(s) return (s:gsub('([^%w])', function(c) return string.format('%%%02X', string.byte(c)) end)) end

    for i, line in ipairs(lines) do
        local indent, content = line:match('^(%s*)(.*)$')
        if content ~= '' then
            local url = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=' .. encode(content)
            vim.fn.jobstart({ 'curl', '-s', '-A', 'Mozilla/5.0', url }, {
                stdout_buffered = true,
                on_stdout = function(_, data)
                    local ok, decoded = pcall(vim.json.decode, table.concat(data, ''))
                    if not ok or not decoded or not decoded[1] then return end
                    local translated = ''
                    for _, seg in ipairs(decoded[1]) do translated = translated .. (seg[1] or '') end
                    translated = indent .. translated
                    vim.schedule(function()
                        local row = s_row - 1 + i - 1
                        if #lines == 1 then
                            vim.api.nvim_buf_set_text(0, row, s_col, row, e_col + 1, { translated })
                        else
                            vim.api.nvim_buf_set_lines(0, row, row + 1, false, { translated })
                        end
                    end)
                end,
            })
        end
    end
end, opts)

