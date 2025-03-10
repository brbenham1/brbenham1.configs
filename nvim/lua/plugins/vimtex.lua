vim.keymap.set("n", "<leader>vc", ":VimtexCompile<CR>")

return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
