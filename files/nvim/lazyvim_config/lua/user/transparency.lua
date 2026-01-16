local M = {}

M.enabled = false -- default value
M.floatLvl = 20

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
  NoiceMini = { bg = "NONE" },
  NoiceMiniBorder = { bg = "NONE" },
  NoiceCmdline = { bg = "NONE" },
  --NoiceCmdlinePopup = { bg = "NONE" },
  NoiceCmdlinePopup = { bg = "#5e5e5e" },
  NoiceCmdlinePopupBorder = { bg = "NONE" },
  NoiceCmdlineIcon = { bg = "NONE" },
  NoicePopupmenu = { bg = "NONE" },
  NoicePopupmenuBorder = { bg = "NONE" },
  NoiceConfirm = { bg = "NONE" },
  NoiceConfirmBorder = { bg = "NONE" },
}

function M.apply()
  for group, opts in pairs(M.highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
  vim.o.pumblend = M.floatLvl
  vim.o.winblend = M.floatLvl

  vim.notify("Transparency ON", vim.log.levels.INFO)
end

function M.toggle()
  M.enabled = not M.enabled
  if M.enabled then
    M.apply()
  else
    vim.cmd.colorscheme(vim.g.colors_name)
    vim.o.pumblend = 0
    vim.o.winblend = 0

    vim.notify("Transparency OFF", vim.log.levels.INFO)
  end
end

function M.init()
  if M.enabled then
    M.apply()
  end
end

return M
