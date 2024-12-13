return {
	"nvim-tree/nvim-tree.lua",
	enabled = true,
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup({
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)
				vim.keymap.set(
					"n",
					"<Esc>",
					api.tree.close,
					{ buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
			end,
			view = {
				signcolumn = "yes",
				float = {
					enable = true,
					open_win_config = {
						title = "nvim-tree",
						title_pos = "center",
						relative = "editor",
						border = "single",
						height = math.floor(vim.o.lines * 0.75),
						width = math.floor(vim.o.columns * 0.7),
						row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.75) - 2) / 2),
						col = math.floor((vim.o.columns - math.floor(vim.o.columns * 0.7) - 2) / 2),
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
