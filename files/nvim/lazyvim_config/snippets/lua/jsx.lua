local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn, fmt =
  ls.snippet,
  ls.text_node,
  ls.insert_node,
  ls.choice_node,
  ls.restore_node,
  ls.function_node,
  ls.snippet_node,
  require("luasnip.extras.fmt").fmt

local snippets = {
  s({ trig = "pre" }, fmt("<pre>{{JSON.stringify({}, null, 2)}}</pre>", { i(0, "var") })),
}

ls.add_snippets("javascriptreact", snippets)
ls.add_snippets("typescriptreact", snippets)
