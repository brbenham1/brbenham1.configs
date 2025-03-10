vim.keymap.set("n", "<leader>vc", ":VimtexCompile<CR>")

return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_general_viewer = "zathura"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
	end,
}
