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

vim.diagnostic.config({ virtual_text = true })

vim.fn.setreg("u", "ouseEffect(() => {}, []);jkIjkl")
vim.fn.setreg("s", "oconst [_, set_] = useState();jk6bh")
vim.fn.setreg("l", 'yoconsole.log()jki"", jkla;jkbblplllpIjk')
