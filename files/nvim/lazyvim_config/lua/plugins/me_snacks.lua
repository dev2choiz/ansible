---@class CoreKeymaps
local keymaps = require("core.keymaps")

local common_exclude = { ".git", ".idea", ".vscode" }

local grep_exclude = vim.list_extend(vim.deepcopy(common_exclude), { "node_modules", "dist", "build" })

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {
      trash = true,
    },
    picker = {
      hidden = true,
      ignored = true,
      exclude = common_exclude,
      sources = {
        files = { hidden = true, ignored = true },
        grep = {
          hidden = true,
          ignored = true,
          exclude = grep_exclude,
        },
      },
    },
    keys = keymaps.snacks,
  },
  --[[init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("snacks").explorer()
        end,
      })
    end,]]
}
