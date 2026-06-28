return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "emmet-language-server",
        "gotestsum",
      },
      max_concurrent_installers = 12,
    },
  },
  {
    "zapling/mason-lock.nvim",
    enabled = false,
    init = function()
      local lockfile_path = vim.env.NEOVIM_MASON_LOCK_PATH
      if lockfile_path == nil or lockfile_path == "" then
        lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json"
      end

      require("mason-lock").setup({
        lockfile_path = lockfile_path,
      })
    end,
  },
}
