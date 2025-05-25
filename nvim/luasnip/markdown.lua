-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- Accessing regex capture groups with LuaSnip
f(function(_, snip)
	return snip.captures[1]
end) -- return first capture group
f(function(_, snip)
	return snip.captures[2]
end) -- return second capture group, etc.

return {
	-- h2 --> ##
	s("h2", t("## ")), -- Might even remove this later, see how I feel
	-- h3 --> ###
	s("h3", t("### ")),
	-- h4 --> ####
	s("h4", t("#### ")),
	-- h5 --> #####
	s("h5", t("##### ")),
	-- h6 --> ######
	s("h6", t("###### ")),
}
