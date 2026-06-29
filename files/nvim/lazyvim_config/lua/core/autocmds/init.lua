local M = {}

local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("autocmds")

local function setup_internal()
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      require("core.transparency.transparency").init()
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
      vim.keymap.del("i", "<left>", { buffer = true })
      vim.keymap.del("i", "<right>", { buffer = true })
    end,
  })
end

local function load_file(file)
  if not fs.file_exists(file) then
    return
  end

  local ok, result = fs.safe_dotfile(file, true)
  if ok then
    logger.debug("loaded: " .. file)
    if type(result) == "table" and type(result.setup) == "function" then
      result.setup()
    end
  else
    logger.warn("failed to load: " .. file)
  end
end

local function load_external()
  local paths = {}

  local global_dir = fs.get_global_config_dir()
  if global_dir then
    table.insert(paths, global_dir .. "/autocmds.lua")
  end

  local project_dir = fs.get_project_config_dir()
  if project_dir then
    table.insert(paths, project_dir .. "/autocmds.lua")
  end

  for _, file in ipairs(paths) do
    load_file(file)
  end
end

function M.setup()
  setup_internal()
  load_external()
end

return M
