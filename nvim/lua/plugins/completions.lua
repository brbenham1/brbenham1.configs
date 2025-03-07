return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- Load when entering insert mode
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source
			"hrsh7th/cmp-buffer", -- Buffer words completion
			"hrsh7th/cmp-path", -- File path completion
			"hrsh7th/cmp-cmdline", -- Command-line completion
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- LuaSnip source
		},

		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- Use LuaSnip
					end,
				},

				-- mapping = cmp.mapping.preset.insert({
				-- 	["<C-Space>"] = cmp.mapping.complete(), -- Open completion menu
				-- 	["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
				-- 	["<C-e>"] = cmp.mapping.abort(), -- Close menu
				-- }),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
