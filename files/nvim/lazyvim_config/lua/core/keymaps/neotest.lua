local function close_output_and_summary()
  local neotest = require("neotest")
  neotest.output_panel.close()
  neotest.output_panel.clear()
  neotest.summary.close()
end

local function open_output_and_summary()
  local neotest = require("neotest")
  close_output_and_summary()
  neotest.summary.open()
  neotest.output_panel.open()
end

return {
  {
    "<leader>td",
    function() require("neotest").run.run({ strategy = "dap" }) end,
    desc = "Debug the nearest",
  },
  {
    "<leader>tr",
    function()
      close_output_and_summary()
      require("neotest").run.run()
    end,
    desc = "Run Nearest (Neotest)",
  },
  {
    "<leader>tR",
    function()
      open_output_and_summary()
      require("neotest").run.run()
    end,
    desc = "Run Nearest with Output Panel (Neotest)",
  },
  {
    "<leader>tt",
    function()
      open_output_and_summary()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    desc = "Run File with Output Panel (Neotest)",
  },
  {
    "<leader>tl",
    function()
      close_output_and_summary()
      require("neotest").run.run_last()
    end,
    desc = "Run Last (Neotest)",
  },
  {
    "<leader>tL",
    function()
      open_output_and_summary()
      require("neotest").run.run_last()
    end,
    desc = "Run Last with Output Panel (Neotest)",
  },
}
