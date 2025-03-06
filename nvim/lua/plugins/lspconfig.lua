return
{
    {
        -- Lazy plugins plus dependencies
        "williamboman/mason-lspconfig.nvim",
        event = "BufReadPost",
        dependencies = {
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim" ,
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

            -- Setup mason lspconfig
            require("mason-lspconfig").setup()

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })

            local mason_registry = require("mason-registry")

            -- LSP servers to install
            local servers = {
                "lua-language-server",
            }

            -- Setup mason tool installer
            require("mason-tool-installer").setup({
                ensure_installed = servers,
                auto_update = false,
            })

            -- Remove unwanted LSPs
            vim.schedule(function()
                local installed_packages = mason_registry.get_installed_package_names()
                for _, pkg_name in ipairs(installed_packages) do
                    if not vim.tbl_contains(servers, pkg_name) then
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
