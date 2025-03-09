local lspStatus = {
	function()
		local msg = "No LSP detected"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end

		local active_clients = {}

		local function add_clients_by_ft(ft_table, buf_ft_param, _)
			for ft_k, ft_v in pairs(ft_table) do
				if buf_ft_param == ft_k then
					if type(ft_v) == "table" then
						for _, item in ipairs(ft_v) do
							table.insert(active_clients, item)
						end
					elseif type(ft_v) == "string" then
						table.insert(active_clients, ft_v)
					end
				end
			end
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				table.insert(active_clients, client.name)
			end
		end

		local lint_s, lint = pcall(require, "lint")
		if lint_s then
			add_clients_by_ft(lint.linters_by_ft, buf_ft, "linter")
		else
			vim.notify("Lint module not found", vim.log.levels.ERROR)
		end

		local formatters_s, formatters = pcall(require, "conform")
		if formatters_s then
			add_clients_by_ft(formatters.formatters_by_ft, buf_ft, "formatter")
		else
			vim.notify("Conform module not found", vim.log.levels.ERROR)
		end

		table.sort(active_clients)

		if #active_clients > 0 then
			return table.concat(active_clients, ", ")
		else
			return msg
		end
	end,
	icon = "",
	color = { fg = "#d3d3d3" },
}

local diagnostic = {
	"diagnostics",
	symbols = {
		error = " ",
		warn = " ",
		info = " ",
		hint = " ",
	},
	icon = "|",
}

local diff = {
	"diff",
	symbols = {
		added = " ",
		modified = " ",
		removed = " ",
	},
}

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "help" },
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_x = { diff, diagnostic },
			lualine_y = { lspStatus, "filetype" },
			lualine_z = { "progress" },
		},
	},
}
