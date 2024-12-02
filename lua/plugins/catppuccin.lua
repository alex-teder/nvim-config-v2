return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local opts = {
			flavour = "mocha",
			no_bold = true,
		}
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin")
	end,
}
