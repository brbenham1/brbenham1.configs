return {
	-- Vim tmux navigator
	"christoomey/vim-tmux-navigator",

	-- nvim-autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			--BUG:
			--TODO:
			--HACK:
			--WARN:
			--NOTE:
			--TEST:

			keywords = {
				-- Configure
				FIX = {
					icon = " ",
					color = "#E82424",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = {
					icon = " ",
					color = "#7E9CD8",
				},
				HACK = {
					icon = " ",
					color = "#FF9E3B",
				},
				WARN = {
					icon = " ",
					color = "#FF9E3B",
					alt = { "WARNING", "XXX" },
				},
				--FIXME:
				-- PERF = {
				-- 	icon = " ",
				-- 	color = "	#957FB8",
				-- 	alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
				-- },
				NOTE = {
					icon = " ",
					color = "#98BB6C",
					alt = { "INFO" },
				},
				TEST = {
					icon = "⏲ ",
					color = "#76946A",
					alt = { "TESTING", "PASSED", "FAILED" },
				},
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
