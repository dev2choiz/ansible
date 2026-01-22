---@class CoreKeymaps
local keymaps = require("core.keymaps")

return {
  { "lewis6991/gitsigns.nvim" },
  {
    "sindrets/diffview.nvim",
    keys = keymaps.diffview,
  },
}
