return {{
    'akinsho/bufferline.nvim',
    tag = "v4.6.1",
    event = "VimEnter",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup{}
    end
}}
