return {
	"tpope/vim-fugitive",
	config = function()
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = "*fugitive*",
			callback = function()
				vim.keymap.set("n", "<CR>", function()
					local current_line = vim.api.nvim_get_current_line()
					local file_name = string.sub(current_line, 2)
					vim.cmd("1tabnext")
					vim.cmd(string.format("e %s", file_name))
					vim.cmd("only")
				end, { silent = true, buffer = 0 })
			end,
		})
	end,
}
