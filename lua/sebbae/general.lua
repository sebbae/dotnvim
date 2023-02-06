vim.g.mapleader = ","

vim.keymap.set("n", " ", ":")

vim.keymap.set("i", "jj", "<esc>", { silent = true })

vim.keymap.set("n", "<tab>", ":bnext<cr>", { silent = true })
vim.keymap.set("n", "<s-tab>", ":bprev<cr>", { silent = true })
vim.keymap.set("n", "<c-d>", ":bd<cr>", { silent = true })

vim.keymap.set("n", "<cr><cr>", ":noh<cr>", { silent = true })

vim.keymap.set("n", "<c-space>", function()
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
end , { silent = true })

--vim.keymap.set("n", "<c-n>", ":Vexplore<cr>", { silent = true })
vim.keymap.set("n", "<c-n>", function()
    local is_open = false
    local netrwbuf = -1

    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do

      if vim.api.nvim_buf_get_option(buffer, 'modified') then
          print("modified")
    else
          print("not modified")
      end
        local filetype = vim.fn.getbufvar(buffer, '&filetype')
        print(buffer .. ' filetype ' .. filetype)
        if filetype == 'netrw' then
            is_open = true
            netrwbuf = buffer
        end
    end

    if is_open then
        local info = vim.fn.getbufinfo(netrwbuf)[1]
        print(info)
        local window = info.windows[1]
        print('Close window ' .. window)
        vim.api.nvim_win_close(window, true)
    else
        vim.cmd('Lexplore')
    end
end, { silent = false })


vim.api.nvim_create_user_command('DeleteTrailingWS', function()
    vim.cmd("%s/\\s\\+$//ge")
end, {})
