return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorador de archivos" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  }