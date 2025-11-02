return  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = "v", desc = "Comment toggle linewise" },
    },
    config = function()
      require("Comment").setup()
    end,
  }