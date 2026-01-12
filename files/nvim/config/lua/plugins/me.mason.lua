---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        {
          -- golang
          "gopls",
          "gotests",
          "goimports",
          -- yaml
          "yaml-language-server",
        }
      )
    end,
  },
}
