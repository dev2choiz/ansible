return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, require("core.keymaps").which_key.spec)

      return opts
    end,
    keys = function()
      return require("core.keymaps").which_key.keys
    end,
  },
}
