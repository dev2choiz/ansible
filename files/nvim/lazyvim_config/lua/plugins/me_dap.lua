---@class CoreKeymaps
local keymaps = require("core.keymaps")

return {
  {
    "leoluz/nvim-dap-go",
    enabled = false,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
    },

    opts = {
      automatic_installation = true,
      ensure_installed = {
        "delve",
        -- "js",
        "python",
      },
    },

    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
      require("core.dap").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    keys = keymaps.dap,
  },
}
