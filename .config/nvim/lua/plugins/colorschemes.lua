return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                extend_background_behind_borders = true,
                enable = {
                    terminal = true,
                    legacy_highlights = true,
                    migrations = true,
                },
                styles = {
                    italic = true,
                    bold = true,
                    transparency = false,
                },
            })
            vim.cmd("colorscheme rose-pine-moon")
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        -- priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavor = "mocha",
                term_colors = true,
            })
            -- vim.cmd("colorscheme catppuccin")
        end
    },
}
