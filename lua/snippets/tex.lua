local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local postfix = require("luasnip.extras.postfix").postfix
local l = require("luasnip.extras").lambda
local MATH_NODES = {
	displayed_equation = true,
	inline_formula = true,
	math_environment = true,
}

local TEXT_NODES = {
	text_mode = true,
	label_definition = true,
	label_reference = true,
}
function in_mathzone()
	local node = vim.treesitter.get_node({ ignore_injections = false })
	local current_filetype = vim.bo.filetype

	-- Check if we are in a markdown file and inside a code block
	if current_filetype == "markdown" or current_filetype == "quarto" then
		local block_node = node
		while block_node do
			if CODE_BLOCK_NODES[block_node:type()] then
				return false -- If in a code block in markdown, never consider it math zone
			end
			block_node = block_node:parent()
		end
	end

	while node do
		if TEXT_NODES[node:type()] then
			return false
		elseif MATH_NODES[node:type()] then
			return true
		end
		node = node:parent()
	end
	return false
end

ls.add_snippets("tex", {
	s(
		{ trig = "env", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
      <>
    ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
				i(3),
			}
		)
	),
  s(
    {trig = "\\lang", snippetType = "autosnippet"},
    fmta([[\langle <> , <> \rangle <>]],{i(1), i(2), i(0)},
    {condition = in_mathzone})
  ),
	-- postfix("hat", { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }), -- lambdas are basically function nodes but perform very simple tasks, e.g. string concatenation/modification
	postfix({
		trig = "hat",
		match_pattern = [[[\\%w%.%_%-%"%']+$]],
		snippetType = "autosnippet",
		dscr = "postfix hat when in math mode",
	}, { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }, { condition = in_mathzone }),
	postfix({
		trig = "vec",
		match_pattern = [[[\\%w%.%_%-%"%']+$]],
		snippetType = "autosnippet",
		dscr = "postfix vec when in math mode",
	}, { l("\\vec{" .. l.POSTFIX_MATCH .. "}") }, { condition = in_mathzone }),

	postfix({
		trig = "tilde",
		match_pattern = [[[\\%w%.%_%-%"%']+$]],
		snippetType = "autosnippet",
		dscr = "postfix tilde when in math mode",
	}, { l("\\tilde{" .. l.POSTFIX_MATCH .. "}") }, { condition = in_mathzone }),
	postfix({
		trig = "wtild",
		match_pattern = [[[\\%w%.%_%-%"%']+$]],
		snippetType = "autosnippet",
		dscr = "postfix wide tilde when in math mode",
	}, { l("\\widetilde{" .. l.POSTFIX_MATCH .. "}") }, { condition = in_mathzone }),
	s(
		"textbf",
		f(function(args, snip)
			local res, env = {}, snip.env
			for _, ele in ipairs(env.LS_SELECT_RAW) do
				table.insert(res, "\\textbf{" .. ele .. "}")
			end
			return res
		end, {})
	),
  s({trig = "\\frac", snippetType = "autosnippet"}, fmta([[\frac{<>}{<>} <>]],{i(1),i(2),i(3)}), {condition = in_mathzone})
})

local greek_letters = {
	{ "alpha", "a" },
	{ "beta", "b" },
	{ "gamma", "g" },
	{ "delta", "d" },
	{ "epsilon", "e" },
	{ "zeta", "z" },
	{ "eta", "n" },
	{ "theta", "h" },
	{ "iota", "i" },
	{ "kappa", "k" },
	{ "lambda", "l" },
	{ "mu", "m" },
	{ "nu", "v" },
	{ "xi", "x" },
	{ "omicron", "" },
	{ "pi", "p" },
	{ "rho", "r" },
	{ "sigma", "s" },
	{ "tau", "t" },
	{ "upsilon", "u" },
	{ "phi", "f" },
	{ "chi", "c" },
	{ "psi", "q" },
	{ "omega", "o" },
}

local greek_snippets = {}

for _, le in ipairs(greek_letters) do
	if le[2] ~= "" then
		local tbl = s({ trig = ";" .. le[2], snippetType = "autosnippet" }, t("\\" .. le[1]), {condition = in_mathzone})
		table.insert(greek_snippets, tbl)
	end
end

ls.add_snippets("tex", greek_snippets)
