---@class CoreTheme
local M = {}

---@return string
function M.get_theme()
  return os.getenv("DOTFILES_THEME") or "gruvbox"
end

return M
