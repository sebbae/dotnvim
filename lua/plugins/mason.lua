return {
  { 'mason-org/mason.nvim', cmd = "Mason", opts = {} },

  {
    'mason-org/mason-lspconfig.nvim',
    event = "BufReadPost",
    dependencies = { 'neovim/nvim-lspconfig', 'mason-org/mason.nvim' },
    opts = {}
  },
}
