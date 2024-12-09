return {
	"nvim-tree/nvim-tree.lua",
	enabled = true,
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup({
			view = {
				signcolumn = "no",
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						height = 33,
						width = 100,
						row = (vim.o.lines - 35) / 2,
						col = (vim.o.columns - 102) / 2,
					},
				},
			},
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
