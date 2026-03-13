local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("snippets")

local M = {}

local function get_snippet_paths()
  local paths = {}

  table.insert(paths, vim.fn.stdpath("config") .. "/snippets")

  table.insert(paths, fs.get_project_config_dir() .. "/snippets")

  local global = fs.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/snippets")
  end

  return paths
end

function M.setup()
  local loader_lua = require("luasnip.loaders.from_lua")
  local loader_vscode = require("luasnip.loaders.from_vscode")

  local paths = get_snippet_paths()

  for _, path in ipairs(paths) do
    if fs.is_dir(path) then
      loader_vscode.lazy_load({ paths = { path .. "/vscode" } })

      -- TODO: try to lazy load
      loader_lua.load({ paths = { path .. "/lua" } })
      logger.debug(path .. " loaded")
    end
  end
end

return M
