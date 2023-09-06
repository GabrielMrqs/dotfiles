return {
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup()

    local handler = function()
      require("nvterm.terminal").toggle("horizontal")
    end

    vim.keymap.set("n", "<leader>h", handler, { desc = "Open terminal horizontally }", remap = true })
  end,
}
