local state = require("core.state").get_transparency()

local M = {}

function M.is_enabled()
  return state.get("enabled", false)
end

function M.set_enabled(v)
  state.set("enabled", v)
end

function M.get_float_lvl()
  return state.get("float_lvl", 20)
end

M.highlights = require("core.transparency.highlights")

local function apply()
  for group, opts in pairs(M.highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
  local float_lvl = M.get_float_lvl()
  vim.o.pumblend = float_lvl
  vim.o.winblend = float_lvl
end

local supported = {
  "gruvbox",
  "tokyonight",
  "catppuccin",
  "kanagawa",
  "rose-pine",
}

local function apply_theme()
  local enabled = M.is_enabled()
  local theme = require("core.utils.theme").get_theme()

  if theme == "gruvbox" then
    local config = require("gruvbox").config or {}
    config.transparent_mode = enabled

    require("gruvbox").setup(config)
  elseif theme == "catppuccin" then
    local config = require("catppuccin").options or {}
    config.transparent_background = enabled
    config.float = config.float or {}
    config.float.transparent = enabled

    require("catppuccin").setup(config)
  elseif theme == "tokyonight" then
    local config = require("tokyonight").config or {}
    config.transparent = enabled
    config.styles = config.styles or {}
    config.styles.sidebars = enabled and "transparent" or "dark"
    config.styles.float = enabled and "transparent" or "dark"

    require("tokyonight").setup(config)
  elseif theme == "kanagawa" then
    local config = require("kanagawa").config or {}
    config.transparent = enabled
    config.dimInactive = false

    require("kanagawa").setup(config)
  elseif theme == "rose-pine" then
    local config = require("rose-pine").config or {}
    config.styles = config.styles or {}
    config.styles.transparency = enabled

    require("rose-pine").setup(config)
  end

  vim.cmd.colorscheme(vim.g.colors_name)
end

function M.toggle()
  local enabled = not M.is_enabled()
  M.set_enabled(enabled)
  local theme = require("core.utils.theme").get_theme()

  if vim.tbl_contains(supported, theme) then
    apply_theme()
    return
  end

  if enabled then
    apply()
  else
    vim.cmd.colorscheme(vim.g.colors_name)
    vim.o.pumblend = 0
    vim.o.winblend = 0
  end
end

function M.init()
  local theme = require("core.utils.theme").get_theme()

  if vim.tbl_contains(supported, theme) then
    apply_theme()
    return
  end

  if M.is_enabled() then
    apply()
  end
end

return M
