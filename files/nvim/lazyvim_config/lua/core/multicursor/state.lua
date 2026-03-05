local state = require("core.state.init").get_multicursor()

local M = {}

local plugin_key = "plugin"

function M.get_plugin()
  return state.get(plugin_key, "vim-visual-multi")
end

function M.set_plugin(v)
  return state.set(plugin_key, v)
end

function M.is_vim_visual_multi()
  return M.get_plugin() == "vim-visual-multi"
end

function M.toggle_plugin()
  if M.is_vim_visual_multi() then
    M.set_plugin("multicursors.nvim")
    return "multicursors.nvim"
  else
    M.set_plugin("vim-visual-multi")
    return "vim-visual-multi"
  end
end

return M
