return {
	"L3MON4D3/LuaSnip",
	config = function()
		local markdown = require("lua_scripts.markdown")
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		ls.config.setup({ enable_autosnippets = true })
		ls.add_snippets("markdown", {
			s({ trig = "`a", snippetType = "autosnippet", condition = markdown.in_mathzone }, { t("\\alpha") }),
			s(
				{ trig = "test2", wordTrig = false, snippetType = "autosnippet", condition = markdown.in_mathzone },
				{ t("\\beta") }
			),
			-- 	s({ trig = "`g", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\gamma") }),
			-- 	s({ trig = "`d", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\delta") }),
			-- 	s({ trig = "`m", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\mu") }),
			-- 	s({ trig = "`n", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\nu") }),
			-- 	s({ trig = "`p", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\pi") }),
			-- 	s({ trig = "`s", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\sigma") }),
			-- 	s({ trig = "`t", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\tau") }),
		})
	end,
}
