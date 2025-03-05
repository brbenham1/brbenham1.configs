-- [[ Kanagawa.nvim color scheme ]]
-- For more options see "https://github.com/rebelot/kanagawa.nvim"
return 
{
    "rebelot/kanagawa.nvim",
    config = function ()
        require("kanagawa").setup ({
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
        })

        vim.cmd.colorscheme("kanagawa-wave")
    end,
}
