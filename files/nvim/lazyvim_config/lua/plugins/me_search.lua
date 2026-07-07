return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      engines = {
        ripgrep = {
          extraArgs = " --glob=!**/.node_modules/*" .. " --glob=!**/dist/*",
        },
      },
      prefills = {
        flags = "--fixed-strings --hidden",
      },
    },
    keys = function()
      return require("core.keymaps.grug_far")
    end,
  },
}
