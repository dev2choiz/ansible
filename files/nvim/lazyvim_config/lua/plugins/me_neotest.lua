return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",

      -- Adapters
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      return require("core.neotest").get_opts(opts)
    end,
    keys = require("core.keymaps.neotest"),
  },
  {
    "andythigpen/nvim-coverage",
    version = "*",
    config = function()
      require("coverage").setup({
        auto_reload = true,
        lang = {
          go = {
            coverage_file = vim.fn.getcwd() .. "/coverage.out",
          },
        },
      })
    end,
  },
}
