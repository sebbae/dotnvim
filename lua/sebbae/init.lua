require("sebbae.general")
require("sebbae.lazy")
require("sebbae.set")
require("sebbae.netrw")
require("sebbae.filetype")

-- include all open buffers for completions
require('cmp').setup {
  sources = {
    {
      name = 'buffer',
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end
    }
  }
}


