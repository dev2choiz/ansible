return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      --transparent_mode = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      --transparent = true,
      styles = {
        --sidebars = "transparent",
        --floats = "transparent",
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
