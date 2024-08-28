return {
    "lervag/vimtex",
    lazy = false,
    config = function()
        vim.g.vimtex_view_method = "zathura"
        -- vim.g.vimtex_syntax_enabled = 0 -- trying to use treesitter instead
    end
}
