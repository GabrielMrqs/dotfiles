return {
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  -- auto tag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
