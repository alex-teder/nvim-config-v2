local opt = vim.opt

opt.nu = true
opt.rnu = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.scrolloff = 8
opt.termguicolors = true
opt.signcolumn = "yes"

opt.swapfile = false
opt.writebackup = false

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*fugitive*",
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			local current_line = vim.api.nvim_get_current_line()
			local file_name = string.sub(current_line, 2)
			vim.cmd(string.format("e %s", file_name))
			vim.cmd("only")
		end, { silent = true, buffer = 0 })
	end,
})
