return {
	"stevearc/oil.nvim",
	enabled = false,
	config = function()
		require("oil").setup({
			watch_for_changes = true,
			columns = { "icon" },
			view_options = { show_hidden = true },
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
