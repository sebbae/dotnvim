return {{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    lazy = true,
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        }
    },
    keys = {
        { '<C-p>', function()
            require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git'} })
        end },
        { '<M-p>', function()
            require('telescope.builtin').find_files({ no_ignore = true })
        end },
        { '<leader>s', function()
            require('telescope.builtin').live_grep({
            additional_args = function(args)
              return vim.list_extend(args, { "--hidden", "-g", "!.git" })
            end})
        end },
        { '<leader>p', function() require('telescope.builtin').buffers() end },
        { '<leader>m', function() require('telescope.builtin').lsp_document_symbols() end },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = { ["<esc>"] = actions.close },
                },
            },
        })
        require("telescope").load_extension("live_grep_args")
    end
}}
