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

M.highlights = {
  -- Normal
  Normal = { bg = "none" },
  SignColumn = { bg = "none" },
  FoldColumn = { bg = "none" },
  NormalNC = { bg = "none" },
  NormalSB = { bg = "none" },
  -- Float
  --NormalFloat = { bg = "none" },
  --FloatBorder = { bg = "none" },
  --FloatTitle = { fg = "#F2F3F5", bg = "none" },
  NormalFloat = { bg = "#1e1e1e" },
  FloatBorder = { bg = "#1e1e1e" },
  FloatTitle = { fg = "#ffffff", bg = "#1e1e1e" },
  -- WinBar
  WinBar = { bg = "none" },
  WinSeparator = { fg = "#F2F3F5", bg = "none" },
  WinBarNC = { bg = "none" },
  WhichKeyFloat = { bg = "none" },
  -- Telescope
  TelescopeBorder = { bg = "none" },
  TelescopePromptTitle = { bg = "none" },
  TelescopePromptBorder = { bg = "none" },
  TelescopeNormal = { bg = "none" },
  -- Diagnosis
  DiagnosticVirtualTextHint = { fg = "#F2F3F5", bg = "none" },
  DiagnosticVirtualTextWarn = { fg = "#e0af68", bg = "none" },
  DiagnosticVirtualTextInfo = { fg = "#9ece6a", bg = "none" },
  DiagnosticVirtualTextError = { fg = "#bd2c00", bg = "none" },
  -- NeoTree
  NeoTreeNormal = { bg = "none" },
  NeoTreeNormalNC = { bg = "none" },
  NeoTreeTabInactive = { bg = "none" },
  NeoTreeTabSeperatorActive = { fg = "#F2F3F5", bg = "none" },
  NeoTreeTabSeperatorInactive = { fg = "#F2F3F5", bg = "none" },
  NvimTreeTabSeperatorActive = { fg = "#F2F3F5", bg = "none" },
  NvimTreeTabSeperatorInactive = { fg = "#F2F3F5", bg = "none" },
  MiniTabLineFill = { fg = "#F2F3F5", bg = "none" },
  -- Spectre
  DiffChange = { fg = "#F2F3F5", bg = "#050a30" },
  DiffDelete = { fg = "#F2F3F5", bg = "#bd2c00" },
  -- StatusLine
  StatusLine = { fg = "#F2F3F5", bg = "none" },
  StatusLineNC = { fg = "#F2F3F5", bg = "none" },
  StatusLineTerm = { fg = "#F2F3F5", bg = "none" },
  StatusLineTermNC = { fg = "#F2F3F5", bg = "none" },
  VertSplit = { fg = "#F2F3F5", bg = "none" },
  -- QuickFixLine
  QuickFixLine = { bg = "none" },
  -- TabLine
  TabLine = { bg = "none" },
  TabLineSel = { bg = "none" },
  TabLineFill = { bg = "none" },
  -- Cursor
  CursorLineNr = { bg = "none" },
  CursorLine = { bg = "none" },
  ColorColumn = { bg = "none" },
  -- Search
  Search = { fg = "red" },
  IncSearch = { fg = "red" },
  -- Pmenu
  Pmenu = { bg = "none" },
  PmenuSel = { bg = "#3c3836" },
  PmenuSbar = { bg = "none" },
  PmenuThumb = { bg = "none" },
  -- Notifications
  NotifyINFOBody = { bg = "none" },
  NotifyWARNBody = { bg = "none" },
  NotifyERRORBody = { bg = "none" },
  NotifyDEBUGBody = { bg = "none" },
  NotifyTRACEBody = { bg = "none" },
  NotifyINFOBorder = { bg = "none" },
  NotifyWARNBorder = { bg = "none" },
  NotifyERRORBorder = { bg = "none" },
  NotifyDEBUGBorder = { bg = "none" },
  NotifyTRACEBorder = { bg = "none" },
  NotifyBackground = { bg = "#000000" },
  --Noice
  NoiceMini = { bg = "none" },
  NoiceMiniBorder = { bg = "none" },
  NoiceCmdline = { bg = "none" },
  NoiceCmdlinePopup = { bg = "none" },
  -- NoiceCmdlinePopup = { bg = "#5e5e5e" },
  NoiceCmdlinePopupBorder = { bg = "none" },
  NoiceCmdlineIcon = { bg = "none" },
  NoicePopupmenu = { bg = "none" },
  NoicePopupmenuBorder = { bg = "none" },
  NoiceConfirm = { bg = "none" },
  NoiceConfirmBorder = { bg = "none" },
}

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

    require("tokyonight").setup(config)
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
