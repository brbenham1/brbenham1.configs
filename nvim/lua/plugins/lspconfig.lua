return {
	{
		-- Lazy plugins plus dependencies
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPost",
		dependencies = {
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
		},

		config = function()
			require("mason").setup({
				-- Configuration here, or leave empty to use defaults
				ui = {
					-- The border style to use for floating windows, can be one of
					-- 'single', 'double', 'rounded', 'solid', 'shadow', or 'none'
					border = "rounded",
				},
			})

			-- LSP capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.workspace.didChangeConfiguration.dynamicRegistration = true
			capabilities.workspace.workspaceFolders = true

			-- Setup mason lspconfig
			require("mason-lspconfig").setup({
				ensure_intalled = {}, -- explicitly set to an empty table (populate via mason-tool-installer)
				automatic_installation = false,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})

			-- LSP servers to install
			local ensure_installed = {
				"lua-language-server",
				"pyright",
			}

			-- Formatters to install
			vim.list_extend(ensure_installed, {
				"stylua",
				"black",
			})

			-- Setup mason tool installer
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			-- Variable for mason registry
			local mason_registry = require("mason-registry")

			-- Configure LSP servers
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			-- Remove unwanted LSPs
			vim.schedule(function()
				local installed_packages = mason_registry.get_installed_package_names()
				for _, pkg_name in ipairs(installed_packages) do
					if not vim.tbl_contains(ensure_installed, pkg_name) then
						local package = mason_registry.get_package(pkg_name)
						if package then
							package:uninstall()
							print(pkg_name .. ": unistalling...")
						end
					end
				end
			end)
		end,
	},
}
