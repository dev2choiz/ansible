local theme = require("core.utils.theme")

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      -- transparent_mode = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      -- transparent = true,
      styles = {
        -- sidebars = "transparent",
        -- floats = "transparent",
      },
    },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      theme = "dragon",
      -- transparent = true,
      dimInactive = false,
      overrides = function(colors)
        return require("core.transparency.highlights").get_kanagawa(colors)
      end,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = theme.get_theme(),
    },
  },
}
