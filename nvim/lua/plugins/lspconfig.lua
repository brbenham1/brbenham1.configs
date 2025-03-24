return {
	{
		-- Lazy plugins plus dependencies
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPost",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"Decodetalkers/csharpls-extended-lsp.nvim",
			"Hoffs/omnisharp-extended-lsp.nvim",
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
				"ts_ls",
				"csharp_ls",
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

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.omnisharp.setup({
				on_attach = on_attach,
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").definition_handler,
					["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
					["textDocument/references"] = require("omnisharp_extended").references_handler,
					["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
				},
				capabilities = capabilities,
				enable_roslyn_analysers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
			})
		end,
	},
}
