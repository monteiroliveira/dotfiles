return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            -- To use latex parser you need to install tree-sitter-cli
            ensure_installed = {
                "vimdoc", "c", "lua", "rust", "haskell", "gitignore",
                "bash", "go",
            },
            ignore_install = { "latex" },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end
}
