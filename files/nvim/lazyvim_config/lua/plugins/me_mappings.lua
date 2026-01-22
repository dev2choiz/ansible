---@class CoreKeymaps
local keymaps = require("core.keymaps")

return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = keymaps.which_key.spec,
    },
    keys = keymaps.which_key.keys,
  },
}
