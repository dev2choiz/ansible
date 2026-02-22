local logger = require("core.utils.logger")

---@class CoreExtras
local M = {}

M.list = {
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.coding.blink" },
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.dap.core" },
  -- { import = "lazyvim.plugins.extras.ai.avante" },
  --{ import = "lazyvim.plugins.extras.ai.copilot" },
  --{ import = "lazyvim.plugins.extras.ai.supermaven" },
  --{ import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.cmake" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.ansible" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.helm" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.editor.overseer" },
  { import = "lazyvim.plugins.extras.util.rest" },
  { import = "lazyvim.plugins.extras.util.dot" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
}

---@param extras1 table|nil
---@param extras2 table|nil
---@return table
function M.merge_extras(extras1, extras2)
  local result = {}
  local index = {}

  local function add(entry)
    if type(entry) ~= "table" or not entry.import then
      logger.warn("extras entry must define `import`")
      return
    end

    local key = entry.import

    if index[key] then
      -- last one wins
      result[index[key]] = entry
      logger.debug("the extras " .. key .. " has been override")
    else
      table.insert(result, entry)
      index[key] = #result
    end
  end

  for _, e in ipairs(extras1 or {}) do
    add(e)
  end

  for _, e in ipairs(extras2 or {}) do
    add(e)
  end

  return result
end

return M
