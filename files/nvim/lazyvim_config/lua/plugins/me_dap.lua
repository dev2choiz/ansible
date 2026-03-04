local dap_dependencies = {
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
    config = function()
      local dap_view = require("dap-view")
      dap_view.setup()
    end,
  },
}

return {
  {
    "leoluz/nvim-dap-go",
    enabled = false,
  },
  {
    "rcarriga/nvim-dap-ui",
  },
  {
    "mfussenegger/nvim-dap",
    keys = function()
      return require("core.keymaps").dap
    end,
    dependencies = {
      unpack(dap_dependencies),
    },
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
        "python",
      },
    },

    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
      require("core.dap").setup()
    end,
  },
}
