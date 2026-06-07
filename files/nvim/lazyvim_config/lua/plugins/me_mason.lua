return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "emmet-language-server",
      },
      max_concurrent_installers = 12,
    },
  },
  {
    "zapling/mason-lock.nvim",
    enabled = false,
    init = function()
      require("mason-lock").setup({
        lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json",
      })
    end,
  },
}
