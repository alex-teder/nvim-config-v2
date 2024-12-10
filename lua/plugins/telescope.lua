return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		defaults = {
			selection_caret = "  ",
			prompt_prefix = "󱞩 ",
		},
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
		local themes = require("telescope.themes")

		vim.keymap.set("n", "<leader>ff", function()
			builtin.git_files(themes.get_ivy())
		end, {})
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep(themes.get_ivy())
		end, {})
		vim.keymap.set("n", "<leader>w", function()
			builtin.buffers(themes.get_ivy())
		end, {})
		vim.keymap.set("n", "<leader>gb", function()
			builtin.git_branches(themes.get_ivy())
		end, {})
		vim.keymap.set("n", "<leader>fh", function()
			builtin.help_tags(themes.get_ivy())
		end, {})
		vim.keymap.set("n", "<leader>fr", function()
			builtin.lsp_references(themes.get_ivy(), { show_line = false })
		end, { noremap = true, silent = true })
	end,
}
