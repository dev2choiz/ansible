local helpers = require("core.utils.helpers")
local logger = require("core.utils.logger").with_source("posting")

---@class CoreHttpPosting
local M = {}

local function load_config(path)
  if helpers.file_exists(path) then
    local ok, conf = helpers.safe_dotfile(path, true)
    if ok and conf and conf.collections then
      return conf.collections
    end
  end
  return {}
end

local function merge_lists(list1, list2)
  local seen = {}
  local result = {}

  for _, v in ipairs(list1) do
    if not seen[v] then
      table.insert(result, v)
      seen[v] = true
    end
  end

  for _, v in ipairs(list2) do
    if not seen[v] then
      table.insert(result, v)
      seen[v] = true
    end
  end

  return result
end

local function init_collections()
  local global = helpers.get_global_config_dir()
  local global_conf = global and load_config(global .. "/posting.lua") or {}

  local project_conf = load_config(helpers.get_root() .. "/.nvim/posting.lua")

  return merge_lists(project_conf, global_conf)
end

M.collections = init_collections()

M.current_collection = M.collections[1]

local function shell_safe_path(path)
  if not path then
    return nil
  end

  path = path:gsub("^~", os.getenv("HOME") or "~")

  return '"' .. path .. '"'
end

function M.select_collection()
  if #M.collections == 0 then
    logger.debug("no collections found")
    return
  end

  local picker_items = {}
  for i, col in ipairs(M.collections) do
    table.insert(picker_items, { idx = i, score = i, text = col, value = col, file = col })
  end

  Snacks.picker({
    title = "Select Posting collection",
    items = picker_items,
    format = function(item)
      return { { item.text, "String" } }
    end,
    confirm = function(picker, item)
      picker:close()
      M.current_collection = item.value
      logger.info("current collection set to: " .. M.current_collection)
    end,
  })
end

function M.run()
  local args = {}
  if M.current_collection then
    table.insert(args, string.format("--collection %s", shell_safe_path(M.current_collection)))
  end

  local cmd = string.format("posting %s", table.concat(args, " "))
  logger.debug(cmd)

  Snacks.terminal.toggle(cmd, { auto_close = true, interactive = true })
end

return M
