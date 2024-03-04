local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
	'gopls'

})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader><leader>", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>w", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<leader>f", function() vim.lsp.buf.format() end, opts)
  vim.keymap.set("i", "<C-space>", function() vim.lsp.buf.completion() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

local util = require 'lspconfig.util'
require('lspconfig.configs').cds_lsp = {
  default_config = {
    name = 'cds-lsp',
    cmd = { 'cds-lsp', '--stdio' },
    filetypes = { 'cds' },
    init_options = {
      provideFormatter = true,
    },
    root_dir = util.find_git_ancestor,
    single_file_support = true,
  },
  docs = {
    description = [[
https://www.npmjs.com/package/@sap/cds-lsp

cds-lsp, a language server for CAP CDS

`cds-lsp` can be installed via `npm`:
```sh
npm i -g @sap/cds-lsp
```
]],
  },
}
require('lspconfig').cds_lsp.setup({})


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = false,
  float = {
    source = "always",  -- Or "if_many"
  }
})
