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
						title = "nvim-tree",
						title_pos = "center",
						relative = "editor",
						border = "single",
						height = 33,
						width = 100,
						row = (vim.o.lines - 35) / 2,
						col = (vim.o.columns - 105) / 2,
					},
				},
			},
			renderer = { icons = { diagnostics_placement = "before" } },
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				debounce_delay = 500,
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "H",
					info = "I",
					warning = "W",
					error = "!",
				},
			},
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
