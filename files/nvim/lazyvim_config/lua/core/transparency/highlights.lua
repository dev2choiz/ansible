local M = {}

M.transparent_highlights = {
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

function M.get_kanagawa(colors)
  local theme = colors.theme
  -- From https://github.com/rebelot/kanagawa.nvim/pull/268/
  return {
    -- SnacksDashboard
    SnacksDashboardHeader = { fg = theme.vcs.removed },
    SnacksDashboardFooter = { fg = theme.syn.comment },
    SnacksDashboardDesc = { fg = theme.syn.identifier },
    SnacksDashboardIcon = { fg = theme.ui.special },
    SnacksDashboardKey = { fg = theme.syn.special1 },
    SnacksDashboardSpecial = { fg = theme.syn.comment },
    SnacksDashboardDir = { fg = theme.syn.identifier },
    -- SnacksNotifier
    SnacksNotifierBorderError = { link = "DiagnosticError" },
    SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
    SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
    SnacksNotifierBorderDebug = { link = "Debug" },
    SnacksNotifierBorderTrace = { link = "Comment" },
    SnacksNotifierIconError = { link = "DiagnosticError" },
    SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
    SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
    SnacksNotifierIconDebug = { link = "Debug" },
    SnacksNotifierIconTrace = { link = "Comment" },
    SnacksNotifierTitleError = { link = "DiagnosticError" },
    SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
    SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
    SnacksNotifierTitleDebug = { link = "Debug" },
    SnacksNotifierTitleTrace = { link = "Comment" },
    SnacksNotifierError = { link = "DiagnosticError" },
    SnacksNotifierWarn = { link = "DiagnosticWarn" },
    SnacksNotifierInfo = { link = "DiagnosticInfo" },
    SnacksNotifierDebug = { link = "Debug" },
    SnacksNotifierTrace = { link = "Comment" },
    -- SnacksProfiler
    SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
    SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
    SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
    SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
    SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
    SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
    SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
    SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
    SnacksZenIcon = { fg = theme.syn.statement },
    SnacksInputIcon = { fg = theme.ui.pmenu.bg },
    SnacksInputBorder = { fg = theme.syn.identifier },
    SnacksInputTitle = { fg = theme.syn.identifier },
    -- SnacksPicker
    SnacksPickerInputBorder = { fg = theme.syn.constant },
    SnacksPickerInputTitle = { fg = theme.syn.constant },
    SnacksPickerBoxTitle = { fg = theme.syn.constant },
    SnacksPickerSelected = { fg = theme.syn.number },
    SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
    SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
    SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
  }
end

return M
