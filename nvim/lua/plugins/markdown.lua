return {
	{
		"dkarter/bullets.vim",
		config = function()
			-- Markdown 2 spaces for tabs for md files
			vim.cmd([[autocmd FileType markdown setlocal tabstop=2 shiftwidth=2]])

			vim.g.bullets_enabled_file_types = { "markdown" }
			vim.g.bullets_outline_levels = { "num" }

			-- Markdown wrap lines
			vim.cmd([[autocmd FileType markdown setlocal wrap]])

			vim.g.bullets_checkbox_markers = " .oOx"
		end,
	},
	{
		-- Install markdown preview, use npx if available.
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		init = function()
			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
