return {
	"nvim-telescope/telescope.nvim",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		require("telescope").setup({
			file_ignore_patterns = {
				".git/",
				"node_modules",
				"target",
				"build",
				"%.lock$",
			},
			defaults = {
				prompt_prefix = "󰍉 ",
				selection_caret = "󰜴 ",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					width = 0.7,
					height = 0.8,
					horizontal = {
						preview_width = 0.6,
					},
					vertical = {
						preview_height = 0.6,
					},
				},
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
						["<C-d>"] = require("telescope.actions").delete_buffer,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-c>"] = require("telescope.actions").close,
					},
				},
			},
			pickers = {
				oldfiles = {
					cwd_only = true,
				},
			},
		})
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<c-p>", builtin.find_files, {})
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fb", function()
			builtin.buffers({
				sort_mru = true,
				ignore_current_buffer = true,
			})
		end)
		vim.keymap.set("n", "<leader>fB", builtin.git_branches, {})
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
