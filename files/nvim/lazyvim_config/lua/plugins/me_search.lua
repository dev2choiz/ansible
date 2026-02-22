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
    keys = function()
      return require("core.keymaps").grug_far
    end,
  },
}
