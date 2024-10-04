return {
    name = "cocoon",
    dir = "$HOME/repos/cocoon.nvim",
    config = function()
        local cocoon = require("cocoon").setup({})

        vim.keymap.set("n", "<leader>cpn", function()
            cocoon.picker:pick_new()
        end)
    end
}
