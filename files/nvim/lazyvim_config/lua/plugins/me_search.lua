---@class CoreKeymaps
local keymaps = require("core.keymaps")

return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      engines = {
        ripgrep = {
          extraArgs = "--glob '!**/node_modules/**' --glob '!**/dist/**'",
        },
      },
    },
    keys = keymaps.grug_far,
  },
}
