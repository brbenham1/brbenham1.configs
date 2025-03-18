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

return {
	-- \texttt
	s(
		{ trig = "tt", dscr = "Expands 'tt' into LaTeX's texttt{} command." },
		fmta("\\texttt{<>}", {
			d(1, get_visual),
		})
	),

	-- \textit
	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		})
	),

	-- \textbf
	s(
		{ trig = "tbf", dscr = "Expands 'tbf' into LaTeX's textbf{} command." },
		fmta("\\textbf{<>}", {
			d(1, get_visual),
		})
	),

	-- \frac
	s(
		{ trig = "ff" },
		fmta("\\frac{<>}{<>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
	),

	-- Equation
	s(
		{ trig = "eq", dscr = "A LaTeX equation environment" },
		fmt(
			[[
      \begin{equation}
          <>
      \end{equation}
    ]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),

	-- Environment
	s(
		{ trig = "env", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
			}
		)
	),
}
