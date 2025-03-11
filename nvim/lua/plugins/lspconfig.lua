return {
	{
		-- Lazy plugins plus dependencies
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPost",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		config = function()
			require("mason").setup({
				-- Configuration here, or leave empty to use defaults
				ui = {
					-- The border style to use for floating windows, can be one of
					-- 'single', 'double', 'rounded', 'solid', 'shadow', or 'none'
					border = "rounded",

					-- Custom icons
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- LSP servers to install
			local servers = {
				"lua_ls",
				"pyright",
				"texlab",
				"html",
				"cssls",
				"eslint",
			}

			-- Setup mason lspconfig
			require("mason-lspconfig").setup({
				ensure_intalled = servers,
				automatic_installation = true,
			})

			-- Require mason-lspconfig
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})

			-- Configure LSP servers
			local lspconfig = require("lspconfig")

			-- LSP capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.workspace.didChangeConfiguration.dynamicRegistration = true
			capabilities.workspace.workspaceFolders = true

			-- on_attach
			local on_attach = function(_, bufner)
				local bufoplevel = { noremap = true, silent = true, buffer = bufner }
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
				vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, {})
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufoplevel)
				vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
				vim.lsp.handlers["textDocument/diagnostics"] = vim.diagnostic.config({
					float = { border = "rounded" },
				})
				vim.lsp.handlers["textDocument/signatureHelp"] =
					vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
				vim.lsp.handlers["textDocument/signatureHelp"] =
					vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.texlab.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
}
