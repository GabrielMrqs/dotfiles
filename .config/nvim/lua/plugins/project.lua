return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- project management
      {
        "ahmedkhalf/project.nvim",
        opts = {
          detection_methods = { "pattern" },
          patterns = {
            "package.json",
            "Cargo.toml",
            "*.sln",
          },
          exclude_dirs = {
            ".git",
            "node_modules",
            "target",
            "bin",
            "obj",
            "nvim-data",
          },
        },
        event = "VeryLazy",
        config = function(_, opts)
          require("project_nvim").setup(opts)
          require("telescope").load_extension("projects")
        end,
        keys = {
          { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
        },
      },
    },
  },
}
