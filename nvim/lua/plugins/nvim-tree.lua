vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<leader>E", ":NvimTreeClose<CR>")
vim.keymap.set("n", "<leader>rf", ":NvimTreeFindFile<CR>")

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		view = {
			adaptive_size = true,
			width = 40,
		},
		update_focused_file = {
			enable = false,
			update_cwd = true,
		},
		sort_by = "name",
		renderer = {
			root_folder_modifier = ":~",
			indent_markers = {
				enable = true,
			},
			highlight_git = true,
			highlight_diagnostics = true,
			icons = {
				git_placement = "after",
				glyphs = {
					git = {
						unstaged = "M",
						staged = "A",
						unmerged = "?",
						renamed = "R",
						untracked = "U",
						deleted = "D",
						ignored = "I",
					},
				},
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
					diagnostics = true,
					bookmarks = true,
				},
			},
		},
		filters = {
			dotfiles = false,
			git_ignored = false,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			debounce_delay = 450,
			severity = {
				min = vim.diagnostic.severity.WARNING,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				error = " ",
				warning = " ",
				hint = " ",
				info = " ",
			},
		},
	},
}
