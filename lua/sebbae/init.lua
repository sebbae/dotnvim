require("sebbae.general")
require("sebbae.lazy")
require("sebbae.set")
require("sebbae.netrw")
require("sebbae.filetype")
require("sebbae.lsp")

-- include all open buffers for completions
--require('cmp').setup {
--  sources = {
--    {
--      name = 'buffer',
--      get_bufnrs = function()
--        return vim.api.nvim_list_bufs()
--      end
--    }
--  }
--}


vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- vim.lsp.config('*', {
--   on_init = function()
--     print('this will be everywhere')
--   end,
-- })
--
-- vim.lsp.config('luals', {
--   on_attach = function()
--     print('luals is now active in this file')
--   end,
-- })
vim.lsp.enable('luals')
