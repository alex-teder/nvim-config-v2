return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		extensions = {
			fzf = {},
		},
		defaults = {
			selection_caret = "  ",
			prompt_prefix = "󱞩 ",
		},
		pickers = {
			git_files = { theme = "ivy" },
			live_grep = { theme = "ivy" },
			git_branches = { theme = "ivy" },
			help_tags = { theme = "ivy" },
			lsp_references = {
				theme = "ivy",
				show_line = false,
			},
			buffers = {
				theme = "ivy",
				initial_mode = "normal",
				show_all_buffers = true,
				sort_lastused = true,
				mappings = {
					n = {
						["dd"] = "delete_buffer",
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.git_files, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>w", builtin.buffers, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>re", builtin.resume, { noremap = true, silent = true })
	end,
}
