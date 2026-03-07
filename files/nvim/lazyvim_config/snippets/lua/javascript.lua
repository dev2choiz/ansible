local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn, fmta =
  ls.snippet,
  ls.text_node,
  ls.insert_node,
  ls.choice_node,
  ls.restore_node,
  ls.function_node,
  ls.snippet_node,
  require("luasnip.extras.fmt").fmta

local snippets = {
  s(
    { trig = "logg", dscr = "console.log snippet" },
    fmta("console.log('<>', <>)", {
      i(1, "name"),
      i(2, "var"),
    })
  ),
}

local filetypes = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
  "vue",
  "svelte",
}

for _, ft in ipairs(filetypes) do
  ls.add_snippets(ft, snippets)
end
