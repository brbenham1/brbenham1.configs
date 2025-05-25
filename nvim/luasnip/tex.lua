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

	-- Equation *
	s(
		{ trig = "eq*", dscr = "A LaTeX equation environment" },
		fmt(
			[[
      \begin{equation*}
          <>
      \end{equation*}
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

	-- \noindent
	s(
		{ trig = "noi", dscr = "Expands 'noi' into LaTeX's \\noindent command." },
		fmta("\\noindent<>", {
			d(1, get_visual),
		})
	),

	-- Insert Cornell Template
	s({ trig = "icn", dscr = "Inserts a blank Cornell note." }, {
		t({
			"\\section*{Lecture Syllabus}",
			"",
			"\\noindent",
			"\\makebox[\\textwidth][c]{%",
			"\t\\begin{tabular}{|p{6.65cm}|p{12.35cm}|}",
			"\t\t\\hline",
			"\t\t\\textbf{Cue} & \\textbf{Notes} \\\\",
			"\t\t\\hline",
			"",
			"\t\t% Cue column",
			"\t\t         &",
			"\t\t% Notes column",
			"\t\t\\\\",
			"\t\t\\hline",
			"\t\\end{tabular}%",
			"}",
		}),
	}),
}
