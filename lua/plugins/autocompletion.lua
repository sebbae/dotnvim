return {
  {
    "hrsh7th/nvim-cmp", 
    dependencies = { "saadparwaiz1/cmp_luasnip", },
    --config = require("plugins.overrides.autocompletion").cmpsetup,
  },
  { "hrsh7th/cmp-buffer",  },
  { "hrsh7th/cmp-path",  },
  { "hrsh7th/cmp-cmdline",  },
  { "hrsh7th/cmp-nvim-lua", },
}
