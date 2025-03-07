return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
		},

		format_on_save = {
			timeour_ms = 2000,
			lsp_format = "fallback",
		},
	},
}
