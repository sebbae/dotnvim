local lint = require('lint')

lint.linters_by_ft = {
  --python = {
    --'pylint',
  --}
}


-- Set pylint to work in virtualenv
--require('lint').linters.pylint.cmd = 'python'
--require('lint').linters.pylint.args = {'-m', 'pylint', '-f', 'json'}
--local pylint_default_args = lint.linters.pylint.args
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    --print("use config " .. vim.fn.findfile('.pylintrc', vim.fn.getcwd()))
    --local pylintrc = vim.fn.findfile('.pylintrc', '.;')
    --if pylintrc ~= '' then
      --lint.linters.pylint.args = {'-f', 'json', '--rcfile', pylintrc, '--source-roots', 'src'}
      --lint.linters.pylint.args = {'-m', 'pylint', '-f', 'json', '--rcfile', pylintrc, '--source-roots', 'src'}
      --print(vim.inspect(lint.linters.pylint.args))
    --else
      --lint.linters.pylint.args = pylint_default_args
    --end
    lint.try_lint()
  end,
})
