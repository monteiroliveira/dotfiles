return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },

    config = function()
        local neogen = require("neogen").setup({})

        vim.keymap.set("n", "<leader>df", function()
            neogen.generate({ type = "func" })
        end)
    end,
}
