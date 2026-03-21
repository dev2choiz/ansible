---@class CoreKeymaps
local M = {}

function M.config_keymaps()
  Snacks.toggle({
    name = "transparency",
    get = function() return require("user.transparency").enabled end,
    set = function() require("user.transparency").toggle() end,
    wk_desc = {
      enabled = "Disable ",
      disabled = "Enable ",
    },
  }):map("<leader>ut")

  Snacks.toggle({
    name = "multicursor",
    get = function() return require("core.multicursor.state").is_vim_visual_multi() end,
    set = function()
      local next_plugin = require("core.multicursor.state").toggle_plugin()

      vim.notify("Multicursor: " .. next_plugin)
    end,
    wk_desc = {
      enabled = "Use multicursor.nvim ",
      disabled = "Use vim-visual-multi ",
    },
    notify = false,
  }):map("<leader>mv")
end

return M
