local builtin = require('telescope.builtin')

-- use <C-Q> to transfer result list to quicklist
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
