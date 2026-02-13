---@class CoreKeymaps
local keymaps = require("core.keymaps")

local common_exclude = { ".git", ".idea", ".vscode" }

local grep_exclude = vim.list_extend(vim.deepcopy(common_exclude), { "node_modules", "dist", "build" })

local tmux = require("core.utils.tmux")

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
        explorer = {
          win = {
            list = {
              keys = {
                ["<c-k>"] = "tmux_navigate_up",
                ["<c-j>"] = "tmux_navigate_down",
                ["<c-h>"] = "tmux_navigate_left",
                ["<c-l>"] = "tmux_navigate_right",
              },
            },
          },
          actions = vim.tbl_extend("force", {}, tmux.explorer_actions),
        },
      },
    },
  },
  keys = keymaps.snacks,
}
