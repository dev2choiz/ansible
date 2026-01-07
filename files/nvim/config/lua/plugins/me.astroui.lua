return {
  "AstroNvim/astroui",
  lazy = false,
  priority = 10000,
  opts = {
    --colorscheme = "catppuccin",
    --colorscheme = "dracula",
    colorscheme = "gruvbox",

    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },

    highlights = {
      init = function()
        require("user.transparency").on_highlights()
      end,
    },
  },
}
