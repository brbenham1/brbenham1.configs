-- Change VimtexCompile to <leader>vc
vim.keymap.set("n", "<leader>vc", ":VimtexCompile<CR>")

-- Manually insert template on new .tex file
vim.api.nvim_create_user_command("InsertLatexTemplate", function()
	local template_path = vim.fn.expand("~/.config/latex-templates/lecture-template.tex")
	local lines = vim.fn.readfile(template_path)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

-- Manually insert cornell notes on new .tex file
vim.api.nvim_create_user_command("InsertLatexCornell", function()
	local template_path = vim.fn.expand("~/.config/latex-templates/cornell-notes.tex")
	local lines = vim.fn.readfile(template_path)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"

		-- Don't open QuickFix for warning messages if no errors are present
		vim.g.vimtex_quickfix_open_on_warning = 0

		-- Filter out some compilation warning messages from QuickFix display
		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull \\hbox",
			"Overfull \\hbox",
			"LaTeX Warning: .+ float specifier changed to",
			"LaTeX hooks Warning",
			'Package siunitx Warning: Detected the "physics" package:',
			"Package hyperref Warning: Token not allowed in a PDF string",
		}
	end,
}
