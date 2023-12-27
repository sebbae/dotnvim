local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})

-- use <C-Q> to transfer result list to quicklist
vim.keymap.set('n', '<C-p>', function()
    --builtin.find_files({hidden=true})
    builtin.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
end, {})
vim.keymap.set('n', '<M-p>', function()
    builtin.find_files({no_ignore=true})
    --builtin.find_files({ find_command = {'rg', '--files', '-H', '-I', '!.git' }})
end, {})
vim.keymap.set('n', '<leader>s', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, {})
vim.keymap.set('n', '<leader>p', builtin.buffers, {})
vim.keymap.set('n', '<leader>m', builtin.lsp_document_symbols, {})
