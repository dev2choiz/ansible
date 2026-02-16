local keymaps = require("core.keymaps")
return {
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = keymaps.auto_session.keys,

    opts = {
      -- mappings on the picker:
      -- delete_session = { "i", "<C-d>" },
      -- alternate_session = { "i", "<C-s>" },
      -- copy_session = { "i", "<C-y>" },
    },
  },
}
