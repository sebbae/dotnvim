return {{
    'nvim-treesitter/nvim-treesitter',
    commit = '37e52c733ada9d8d544d53a763140ef1ba404353',
    lazy = false,
    event = "VimEnter",
    build = ':TSUpdate',

    config = function()
        local ts = require("nvim-treesitter")

        ts.setup({
          install_dir = vim.fn.stdpath("data") .. "/site",
        })

        -- Install non-bundled parsers you want (do NOT include markdown, markdown_inline, lua, vim, vimdoc, c, or query)
        ts.install({
          "yaml",
          "javascript",
          "typescript",
          "python"
        })

        -- Enable native Neovim Tree-sitter highlighting automatically when a parser exists
        vim.api.nvim_create_autocmd("FileType", {
          callback = function(args)
            pcall(vim.treesitter.start, args.buf)
          end,
        })
  end
}}
