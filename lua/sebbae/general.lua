vim.g.mapleader = ","

vim.keymap.set("n", " ", ":")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("i", "jj", "<esc>", { silent = true })

vim.keymap.set("n", "<tab>", ":bnext<cr>", { silent = true })
vim.keymap.set("n", "<s-tab>", ":bprev<cr>", { silent = true })
vim.keymap.set("n", "<c-d>", ":bd<cr>", { silent = true })

vim.keymap.set("n", "<cr><cr>", ":noh<cr>", { silent = true })

vim.keymap.set("n", "<leader>64d", "B64Decode", { silent = true })
vim.keymap.set("n", "<leader>64e","B64Encode", { silent = true })

local toggleQuickfix = function()
    local quickfixbuffer = -1
    local curbuf = -1
    local active = false

    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        local buftype = vim.fn.getbufvar(buffer, '&buftype')
        if buftype == 'quickfix' then
            quickfixbuffer = buffer
        end
    end

    if quickfixbuffer ~= -1 then
        for _, w in ipairs(vim.api.nvim_list_wins()) do
            curbuf = vim.api.nvim_win_get_buf(w)
            if curbuf == quickfixbuffer then
                active = true
            end
        end
        if active == true then
            vim.cmd("cclose")
        else
            vim.cmd("copen")
        end
    else
        vim.cmd("copen")
    end
end

local toggleNetRW = function(dir)
    local is_open = false
    local netrwbuf = -1

    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        local filetype = vim.fn.getbufvar(buffer, '&filetype')
        if filetype == 'netrw' then
            is_open = true
            netrwbuf = buffer
        end
    end

    if is_open then
        local info = vim.fn.getbufinfo(netrwbuf)[1]
        local window = info.windows[1]
        if (#vim.api.nvim_list_wins() == 1) then
            return
        end
        vim.api.nvim_win_close(window, true)
    elseif (dir == nil or dir == '') then
        vim.cmd('Lexplore')
    else
        vim.cmd('Lexplore ' .. dir)
    end
end

vim.keymap.set("n", "<c-space>", toggleQuickfix, { silent = true })
vim.keymap.set("n", "<c-n>", toggleNetRW, { silent = false })
vim.keymap.set("n", "<m-n>", function()
    toggleNetRW(vim.fn.expand('%:p:h'))
end, { silent = false })


vim.api.nvim_create_user_command('DeleteTrailingWS', function()
    vim.cmd("%s/\\s\\+$//ge")
end, {})

-- Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "]]", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "[[", 'copilot#Dismiss()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Next()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-[>", 'copilot#Previous()', { silent = true, expr = true })
