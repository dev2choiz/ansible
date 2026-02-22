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
