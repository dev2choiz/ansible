local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn, fmta, postfix =
  ls.snippet,
  ls.text_node,
  ls.insert_node,
  ls.choice_node,
  ls.restore_node,
  ls.function_node,
  ls.snippet_node,
  require("luasnip.extras.fmt").fmta,
  require("luasnip.extras.postfix").postfix

ls.add_snippets("go", {
  postfix({ trig = ".cl", dscr = "close channel", name = "name" }, {
    f(function(_, parent)
      return "close(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
    end),
  }),
  s(
    { trig = "selctx", dscr = "select with ctx.Done() check" },
    fmta(
      [[
select {
case <<-ctx.Done():
    return
case <>:
}
]],
      { i(0, "data") }
    )
  ),
  s(
    { trig = "err", dscr = "if err != nil" },
    fmta(
      [[
if err != nil {
    return <>
}
]],
      { i(0, "err") }
    )
  ),
})
