return {
    name = "cocoon",
    dir = "$HOME/repos/cocoon.nvim",
    dev = {true},
    config = function()
        local cocoon = require("cocoon")
        cocoon:setup({})

        vim.keymap.set("n", "<leader>m", function ()
            cocoon:call_terminal_win("tmuxprjmgr")
        end)
    end
}
