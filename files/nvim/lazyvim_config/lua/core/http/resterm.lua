local utils = require("core.utils.helpers")
local logger = require("core.utils.logger").with_source("Resterm")

---@class CoreHttpResterm
local M = {}

M.current_config = nil

local function get_all_configs()
  local seen = {}
  local result = {}

  local function add(list)
    for _, cfg in ipairs(list or {}) do
      local key = cfg.workspace
      if key and not seen[key] then
        table.insert(result, cfg)
        seen[key] = true
      end
    end
  end

  local project_file = utils.get_root() .. "/.nvim/resterm.lua"
  if utils.file_exists(project_file) then
    local ok, conf = utils.safe_dotfile(project_file, true)
    if ok and conf and conf.configs then
      add(conf.configs)
    end
  end

  local global_dir = utils.get_global_config_dir()
  if global_dir then
    local global_file = global_dir .. "/resterm.lua"
    if utils.file_exists(global_file) then
      local ok, conf = utils.safe_dotfile(global_file, true)
      if ok and conf and conf.configs then
        add(conf.configs)
      end
    end
  end

  return result
end

local function init_current_config()
  if M.current_config then
    return
  end

  local configs = get_all_configs()
  if #configs > 0 then
    M.current_config = configs[1]
  end
end

function M.select_workspace()
  local configs = get_all_configs()

  if #configs == 0 then
    logger.debug("no configs found")
    return
  end

  local items = {}
  for i, cfg in ipairs(configs) do
    table.insert(items, {
      idx = i,
      score = i,
      text = cfg.workspace,
      value = cfg,
    })
  end

  Snacks.picker({
    title = "Select Resterm config",
    items = items,
    format = function(item)
      return {
        { item.value.name or item.text, "String" },
      }
    end,
    preview = function(ctx)
      ctx.preview:highlight({ ft = "lua" })
      ctx.preview:set_lines(vim.split(vim.inspect(ctx.item.value), "\n"))
    end,
    confirm = function(picker, item)
      picker:close()
      M.current_config = item.value
      logger.info("workspace set to: " .. item.value.workspace)
    end,
  })
end

function M.run()
  init_current_config()

  local args = {}
  local env = {}

  if M.current_config then
    if M.current_config.workspace then
      table.insert(args, string.format("-workspace %q", M.current_config.workspace))
    end

    if M.current_config.args then
      for _, a in ipairs(M.current_config.args) do
        table.insert(args, a)
      end
    end

    if M.current_config.env then
      for k, v in pairs(M.current_config.env) do
        table.insert(env, string.format("%s=%q", k, v))
      end
    end
  end

  local cmd = string.format("%s resterm %s", table.concat(env, " "), table.concat(args, " "))
  logger.debug(cmd)

  Snacks.terminal.toggle(cmd, { auto_close = true, interactive = true })
end

return M
