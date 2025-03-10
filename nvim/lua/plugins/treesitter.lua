local config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"markdown",
			"markdown_inline",
			"query",
			"latex",
			"bash",
		},

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			enable = true,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Leader>ss",
				node_incremental = "<Leader>si",
				scope_incremental = "<Leader>sc",
				node_decremental = "<Leader>sd",
			},
		},

		textobjects = {
			select = {
				enable = true,

				lookahead = true,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },

					-- You can also use captures from other query groups like `locals.scm`
					["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
				},

				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},

				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true or false
				include_surrounding_whitespace = true,
			},
		},
	})
end

return {
	{
		-- [[ Nvim Treesitter ]]
		-- For more options see "https://github.com/nvim-treesitter/nvim-treesitter"
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = config,
	},

	-- [[ Nvim Treesitter Textobjects ]]
	-- For more options see "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
