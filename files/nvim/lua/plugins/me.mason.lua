-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

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
          "delve",
          "gomodifytags",
          "gotests",
          "iferr",
          "impl",
          "goimports",
          -- yaml
          "yaml-language-server",
        }
      )
    end,
  },
}
