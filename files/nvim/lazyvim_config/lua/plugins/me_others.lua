return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufEnter",
    opts = { "*" },
  },
  {
    "artemave/workspace-diagnostics.nvim",
    lazy = true,
    config = function()
      require("workspace-diagnostics").setup({
        workspace_files = function()
          return vim.fn.split(
            vim.fn.system([[
              find . -type f \
                -not -path "*/node_modules/*"
                -not -path "*/.git/*"
                -not -path "*/vendor/*"
                -not -path "*/dist/*"
                -not -path "*/build/*"
                -not -path "*/.vite/*"
                -not -path "*/bin/*"
                -not -path "*/.terraform/*"
                -not -path "*/.idea/*"
                -not -path "*/.vscode/*"
                -not -path "*/.cache/*"
                -not -path "*/logs/*"
            ]]),
            "\n"
          )
        end,
      })
    end,
  },
}
