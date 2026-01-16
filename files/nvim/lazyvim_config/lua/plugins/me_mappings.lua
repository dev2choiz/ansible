return {
  {
    "LazyVim/LazyVim",
    keys = {
      { "<Leader>ut", function() require("user.transparency").toggle() end, desc = "Toggle transparency", },
    },
  },
}