return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      --transparent_mode = true,
    },
  },
  {
    "folke/tokyonight.nvim",
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
  },
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "catppuccin",
    },
  },
}