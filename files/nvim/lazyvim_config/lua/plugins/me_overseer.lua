return {
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      require("core.overseer").setup(vim.tbl_extend("force", opts or {}, {
        task_list = {
          min_height = { 12, 0.3 },
        },
      }))
      require("overseer").add_template_hook({ name = ".*" }, function()
        vim.cmd("OverseerOpen")
      end)
    end,
  },
}
