return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs_staged_enable = false,
		})

		vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { silent = true, desc = "Next Hunk" })
		vim.keymap.set("n", "<leader>gN", ":Gitsigns prev_hunk<CR>", { silent = true, desc = "Previous Hunk" })
		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { silent = true, desc = "Preview Hunk" })
		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, desc = "Reset Hunk" })
		vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { silent = true, desc = "Reset Buffer" })
		vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Stage Hunk" })
		vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", { silent = true, desc = "Stage Buffer" })
	end,
}
