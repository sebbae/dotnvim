local util = require 'lspconfig.util'

local bin_name = 'cds-lsp'
local cmd = { bin_name, '--stdio' }

return {
  default_config = {
    cmd = cmd,
    filetypes = { 'cds' },
    init_options = {
      provideFormatter = true,
    },
    root_dir = util.find_git_ancestor,
    single_file_support = true,
  },
  docs = {
    description = [[
https://github.com/hrsh7th/vscode-langservers-extracted

cds-lsp, a language server for CAP CDS

`cds-lsp` can be installed via `npm`:
```sh
npm i -g @sap/cds-lps
```
]],
    default_config = {
      root_dir = [[util.find_git_ancestor]],
    },
  },
}
