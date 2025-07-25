local markdown = require("lua_scripts.markdown")

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

function Snippets_config()
	ls.add_snippets("markdown", {
		s({ trig = "test", snippetType = "autosnippet" }, { t("\\alpha") }),
		-- 	s({ trig = "`b", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\beta") }),
		-- 	s({ trig = "`g", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\gamma") }),
		-- 	s({ trig = "`d", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\delta") }),
		-- 	s({ trig = "`m", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\mu") }),
		-- 	s({ trig = "`n", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\nu") }),
		-- 	s({ trig = "`p", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\pi") }),
		-- 	s({ trig = "`s", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\sigma") }),
		-- 	s({ trig = "`t", wordTrig = false, snippetType = "autosnippet", condition = math_mode }, { t("\\tau") }),
	})
end
