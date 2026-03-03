local M = {}

local state_dir = vim.fn.stdpath("data") .. "/mystate"
vim.fn.mkdir(state_dir, "p")

local registry = {}

local function get_path(filename)
  return state_dir .. "/" .. filename
end

local function read_file(path)
  local f = io.open(path, "r")
  if not f then
    return {}
  end

  local ok, data = pcall(vim.fn.json_decode, f:read("*all"))
  f:close()

  return ok and data or {}
end

local function write_file(path, data)
  local f = io.open(path, "w")
  if not f then
    return
  end

  f:write(vim.fn.json_encode(data))
  f:close()
end

function M.create_state(name)
  local path = get_path(name)
  local data = read_file(path)
  local dirty = false

  local function flush()
    if dirty then
      write_file(path, data)
      dirty = false
    end
  end

  local state = {
    get = function(key, default)
      local value = data[key]
      if value == nil then
        return default
      end
      return value
    end,

    set = function(key, value)
      data[key] = value
      dirty = true
      -- flush()
    end,

    raw = function()
      return data
    end,

    flush = flush,
  }

  registry[#registry + 1] = state

  return state
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    for _, state in ipairs(registry) do
      state.flush()
    end
  end,
})

return M
