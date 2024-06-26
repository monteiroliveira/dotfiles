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
            vim.cmd("colorscheme rose-pine")
        end
    },
}
