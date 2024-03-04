vim.filetype.add({
  extension = {
    cds = 'cds'
  },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end
})

vim.api.nvim_create_augroup("AutoFormat", {})

-- autoformat python files on save
if vim.fn.executable('black') == 1 then
    vim.api.nvim_create_autocmd(
        "BufWritePost",
        {
            pattern = "*.py",
            group = "AutoFormat",
            callback = function()
                vim.cmd("silent !black --quiet %")
                vim.cmd("edit")
            end,
        }
    )
end
