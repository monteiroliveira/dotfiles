vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ne", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", vim.cmd.so)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("x", "<leader>p", "\"_dP")

-- Expand a project into tmux
vim.keymap.set("n", "<C-f>", function()
    if os.getenv("TMUX") ~= nil then
        vim.cmd("silent !tmux neww tmuxprjmgr")
        return
    end
    vim.cmd.terminal("tmuxprjmgr")
end)

-- Expand another section in tmux (this command inside a session is kind dumb)
vim.keymap.set("n", "<C-i>", function()
    if os.getenv("TMUX") ~= nil then
        vim.cmd("silent !tmux neww tmuxsessmgr")
        return
    end
end)
