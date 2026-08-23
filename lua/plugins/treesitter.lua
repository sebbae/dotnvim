return {{
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.10.0',
    event = "VimEnter",
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "vimdoc", "javascript", "typescript", "go", "c", "lua", "vim", "rust" },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}}
