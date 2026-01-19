return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>a", group = "ai" },
          { "<leader>gv", group = "diffview" },
        },
      },
    },
    keys = {
      {
        "<Leader>ut",
        function()
          require("user.transparency").toggle()
        end,
        desc = "Toggle transparency",
      },
    },
  },
}
