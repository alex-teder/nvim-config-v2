local opt = vim.opt

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.scrolloff = 8
opt.updatetime = 50
opt.termguicolors = true

opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.swapfile = false
opt.writebackup = false

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
