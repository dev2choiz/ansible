return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(
              opts.ensure_installed or {},
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
