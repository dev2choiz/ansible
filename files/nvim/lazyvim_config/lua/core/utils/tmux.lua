local M = {}

local function in_tmux()
  return vim.env.TMUX ~= nil
end

local function tmux_is_zoomed()
  if not in_tmux() then
    return false
  end

  local ok, result = pcall(vim.fn.systemlist, "tmux display-message -p '#{window_zoomed_flag}'")
  if not ok or not result[1] then
    return false
  end
  return result[1] == "1"
end

local function tmux(cmd)
  if in_tmux() and not tmux_is_zoomed() then
    vim.fn.system("tmux " .. cmd)
  end
end

M.explorer_actions = {
  tmux_navigate_up = function()
    tmux("select-pane -U")
  end,
  tmux_navigate_down = function()
    tmux("select-pane -D")
  end,
  tmux_navigate_left = function()
    tmux("select-pane -L")
  end,
  tmux_navigate_right = function()
    -- tmux("select-pane -R")
    vim.cmd("TmuxNavigateRight")
  end,
}

return M
