return {
	"mfussenegger/nvim-lint",
	opts = {},
	config = function()
		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufReadPost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
