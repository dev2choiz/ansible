local multicursor = {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<M-Up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<M-Down>", function()
        mc.lineAddCursor(1)
      end)

      -- set({ "n", "x" }, "<leader><up>", function()
      --   mc.lineSkipCursor(-1)
      -- end)
      -- set({ "n", "x" }, "<leader><down>", function()
      --   mc.lineSkipCursor(1)
      -- end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<C-n>", function()
        mc.matchAddCursor(1)
      end, { desc = "Match Next Cursor" })
      set({ "n", "x" }, "<M-x>", function()
        mc.matchSkipCursor(1)
      end, { desc = "Match Skip Next Cursor" })
      set({ "n", "x" }, "<C-p>", function()
        mc.matchAddCursor(-1)
      end, { desc = "Match Previous Cursor" })
      set({ "n", "x" }, "<M-X>", function()
        mc.matchSkipCursor(-1)
      end, { desc = "Match Skip Previous Cursor" })

      -- Add and remove cursors with control + left click.
      -- set("n", "<c-leftmouse>", mc.handleMouse)
      -- set("n", "<c-leftdrag>", mc.handleMouseDrag)
      -- set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<Tab>", mc.nextCursor)
        layerSet({ "n", "x" }, "<S-Tab>", mc.prevCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<C-d>", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}

local visual_multi = {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Find Prev"] = "<C-p>",

      ["Skip Region"] = "<M-x>",
      -- ["Skip Prev"] = "<M-X>",

      -- Vertical cursors
      -- ["Add Cursor Down"] = "<M-Down>",
      -- ["Add Cursor Up"] = "<M-Up>",
      ["Select Cursor Down"] = "<M-Down>",
      ["Select Cursor Up"] = "<M-Up>",

      ["Select All"] = "<C-M-n>",
      ["Visual All"] = "<C-M-n>",

      ["Remove Region"] = "<C-d>",

      ["I Next"] = "<Tab>",
      ["I Prev"] = "<S-Tab>",

      ["Goto Next"] = "]",
      ["Goto Prev"] = "[",

      ["Toggle Mappings"] = "<C-q>",

      ["Exit"] = "<Esc>",

      ["Undo"] = "u",
      ["Redo"] = "<C-r>",

      ["Reselect Last"] = "<C-M-r>",
    }
  end,
}

return {
  visual_multi,
  -- multicursor,
}
