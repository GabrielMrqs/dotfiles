return {
  {
    -- noicer ui
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>sn"] = { name = "+noice" }
    end,
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
}
