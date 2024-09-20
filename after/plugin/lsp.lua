local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.ensure_installed({
	'ts_ls',
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


local on_attach = function(client, bufnr)
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
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

lsp.on_attach(on_attach)
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

local function build_pylint_args()
  local function resolve_cfg_file(filename)
      local cwd = vim.fn.getcwd()
      local found = vim.fn.findfile(filename, '.;')
      if found == "" then
        return ""
      else
          if found:sub(1, 1) == '/' then
              return found
          else
              return (cwd .. '/' .. found)
          end
      end
  end

  local function resolve_directory(directory)
      local cwd = vim.fn.getcwd()
      local found = vim.fn.finddir(directory, '.;')
      if found == "" then
        return ""
      else
          if found:sub(1, 1) == '/' then
              return found
          else
              return (cwd .. '/' .. found)
          end
      end
  end

  local args = {}
  local pylintrc = resolve_cfg_file(".pylintrc")
  if pylintrc ~= "" then
      table.insert(args, "--rcfile=" .. pylintrc)
  end
  local source_roots = resolve_directory("src")
  if source_roots ~= "" then
      table.insert(args, "--source-roots=" .. source_roots)
  end
  return args
end

local function choose_pylint()
 local venv_path = os.getenv('VIRTUAL_ENV')
 if venv_path ~= nil then
   return venv_path .. "/bin/pylint"
 end
 return "pylint"
end

require('lspconfig').pylsp.setup {
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = {
          enabled = true,
          executable =choose_pylint(),
          args = build_pylint_args(),
        },
        ruff = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = {
          enabled = false,
          overrides = { "--python-executable", py_path, true },
          report_progress = true,
          live_mode = false
        },
        -- auto-completion options
        jedi_completion = { fuzzy = false },
        -- import sorting
        isort = { enabled = true },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = capabilities,
}

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


vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      --buffer = args.buf,
      pattern = "*.go",
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})
