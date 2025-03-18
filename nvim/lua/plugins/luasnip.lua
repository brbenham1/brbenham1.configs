return {
	"L3MON4D3/LuaSnip",

	-- Build Step is needed for regex support in snippets.
	-- This step is not supported in many windows environments.
	-- Remove the below condition to re-enable on windows.
	build = function()
		if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
			return
		end
		return "make install_jsregexp"
	end,

	config = function()
		local luasnip = require("luasnip")

		-- LuaSnip settings
		luasnip.config.set_config({
			-- Enable autotriggered snippets
			enable_autosnippets = true,

			-- Use Tab (or some other key if you prefer) to trigger visual selection
			store_selection_keys = "<Tab>",
		})

		-- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
		require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/luasnip/" })

		-- Store auxiliary files in 'build/'
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-auxdir=build",
				"-interaction=nonstopmode",
				"-shell-escape",
				"-synctex=1",
			},
		}

		-- Expand or jump in insert mode
		vim.keymap.set("i", "<Tab>", function()
			return luasnip.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
		end, { expr = true, silent = true })

		-- Jump forward through tabstops in visual mode
		vim.keymap.set("s", "<Tab>", function()
			return luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
		end, { expr = true, silent = true })

		-- Jump backward through snippet tabstops with Shift-Tab
		vim.keymap.set("i", "<S-Tab>", function()
			return luasnip.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
		end, { expr = true, silent = true })

		vim.keymap.set("s", "<S-Tab>", function()
			return luasnip.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
		end, { expr = true, silent = true })
	end,
}
