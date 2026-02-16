---@class CoreKeymaps
local keymaps = require("core.keymaps")

return {
  {
    "leoluz/nvim-dap-go",
    enabled = false,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "mfussenegger/nvim-dap",
    keys = keymaps.dap,
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
        config = function()
          local dap_view = require("dap-view")
          dap_view.setup()

          local dap = require("dap")

          dap.listeners.after.event_initialized["dap-view"] = function()
            dap_view.open()
          end

          dap.listeners.before.event_terminated["dap-view"] = function()
            dap_view.close()
          end

          dap.listeners.before.event_exited["dap-view"] = function()
            dap_view.close()
          end
        end,
      },
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
