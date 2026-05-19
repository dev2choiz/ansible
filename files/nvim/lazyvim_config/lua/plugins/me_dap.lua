return {
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    config = function()
      -- just to disable the setup of the plugin
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "console",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 30,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.25,
            },
            {
              id = "scopes",
              size = 0.75,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    },
  },
  {
    "igorlfs/nvim-dap-view",
    lazy = true,

    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        default_section = "scopes",
      },
      windows = {
        terminal = {
          size = 0.3,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = function()
      return require("core.keymaps.dap")
    end,
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
      },
    },

    config = function()
      require("core.dap").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    enabled = false,
  },
}
