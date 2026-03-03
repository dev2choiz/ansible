-- disabled for now because it breaks the filetype detection for the first buffer when i do `nvim .`
if true then
  return {}
end

return {
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = function()
      return require("core.keymaps").auto_session.keys
    end,

    opts = {
      -- mappings on the picker:
      -- delete_session = { "i", "<C-d>" },
      -- alternate_session = { "i", "<C-s>" },
      -- copy_session = { "i", "<C-y>" },
    },
  },
}
