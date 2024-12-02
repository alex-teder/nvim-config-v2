return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup({
			view = { adaptive_size = true },
			renderer = { highlight_diagnostics = "all" },
			update_focused_file = { enable = true },
			filters = { custom = { "^.git$" } },
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
		})

		vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { silent = true })
	end,
}
