return {
    {
      dir = "/Users/d059503/git/sebbae/nvim-worktrees", -- will be loaded directly from the local path
      name = "worktrees",                              -- needed since there's no slug to derive it from
      dependencies = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("worktrees").setup()
      end,
    },
  }

