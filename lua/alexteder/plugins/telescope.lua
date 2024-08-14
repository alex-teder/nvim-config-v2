return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		pickers = {
			buffers = {
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
		--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "Find file" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep in project" })
		vim.keymap.set("n", "<leader>w", builtin.buffers, {})
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fr", function()
			builtin.lsp_references({ show_line = false })
		end, { noremap = true, silent = true, desc = "Find references" })
	end,
}
