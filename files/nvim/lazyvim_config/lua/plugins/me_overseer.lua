return {
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      require("core.overseer").setup(opts)
    end,
  },
}
