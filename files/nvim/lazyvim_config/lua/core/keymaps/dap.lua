return {
  {
    "<F5>",
    function()
      require("dap").continue()
    end,
    desc = "DAP Continue",
  },
  {
    "<F7>",
    function()
      require("dap").step_into()
    end,
    desc = "DAP Step Into",
  },
  {
    "<F8>",
    function()
      require("dap").step_over()
    end,
    desc = "DAP Step Over",
  },
  {
    "<F6>", -- todo: try to change to <S-F8>
    function()
      require("dap").step_out()
    end,
    desc = "DAP Step Out",
  },
  {
    "<F9>",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "DAP Toggle Breakpoint",
  },
  {
    "<F10>",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "DAP Conditional Breakpoint",
  },
  {
    "<leader>dv",
    function()
      local used_plugin = require("core.dap.state").toggle_ui_plugin()
      vim.notify("DAP UI: " .. used_plugin, vim.log.levels.INFO)
    end,
    desc = "Toggle DAP View UI",
  },
}
