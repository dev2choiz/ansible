local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn, fmt, fmta, postfix, rep =
	ls.snippet,
	ls.text_node,
	ls.insert_node,
	ls.choice_node,
	ls.restore_node,
	ls.function_node,
	ls.snippet_node,
	require("luasnip.extras.fmt").fmt,
	require("luasnip.extras.fmt").fmta,
	require("luasnip.extras.postfix").postfix,
	require("luasnip.extras").rep

ls.add_snippets("go", {
	postfix({ trig = ".cl", dscr = "close channel", name = "close chan" }, {
		f(function(_, parent) return "close(" .. parent.snippet.env.POSTFIX_MATCH .. ")" end),
	}),
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
	postfix(
		{ trig = ".selctx", dscr = "select with ctx.Done() and channel receive", name = "select ctx" },
		fmta(
			[[
	var <> <>
	var ok bool
	select {
	case <<-ctx.Done():
		return
	case <>, ok = <<-<>:
		if !ok {
			return
		}
	}
      ]],
			{
				i(1, "name"),
				i(2, "type"),
				rep(1),
				f(function(_, parent) return parent.snippet.env.POSTFIX_MATCH end),
			}
		)
	),
})
