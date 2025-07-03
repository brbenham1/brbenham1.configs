return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"onsails/lspkind-nvim",
		},
	},

	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- Set completion menu height/width
		vim.o.pumheight = 15
		vim.o.pumwidth = 50

		cmp.setup({
			formatting = {
				-- kind is icon, abbr is completion name, menu is [Function]
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local function commom_format(e, item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							-- show_labelDetails = true, -- show labelDetails in menu. Disabled by default
						})(e, item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = ""
						kind.concat = kind.abbr
						return kind
					end
					-- if get_mode() == "c" then
					--     return commom_format(entry, vim_item)
					-- end
					return commom_format(entry, vim_item)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					side_padding = 0,
					col_offset = -4,
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					col_offset = 0,
					side_padding = 0,
				}),
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			completeopt = "menu,menuone,noselect",
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			mapping = cmp.mapping.preset.insert({
				-- Select the [n]ext item
				["<Tab>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<S-Tab>"] = cmp.mapping.select_prev_item(),

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = false,
				}),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-n>"] = cmp.mapping.complete({}),
			}),

			sources = {
				{
					name = "lazydev",
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "nvim_lsp_signature_help" },
			},
		})
	end,
}
