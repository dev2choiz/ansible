return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      explorer = {
        trash = true,
      },
    },
    --[[init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("snacks").explorer()
        end,
      })
    end,]]
  },
}
