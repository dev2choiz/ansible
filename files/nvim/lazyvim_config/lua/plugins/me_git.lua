return {
  { "lewis6991/gitsigns.nvim" },
  {
    "sindrets/diffview.nvim",
    keys = function()
      return require("core.keymaps").diffview
    end,
  },
}
