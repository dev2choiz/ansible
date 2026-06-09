return {
  {
    "<leader>td",
    function() require("neotest").run.run({ strategy = "dap" }) end,
    desc = "Debug the nearest",
  },
}
