return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					italic = true,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end
	},
}
