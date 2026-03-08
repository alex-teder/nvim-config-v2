vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>")

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>vs", ":vsplit<CR>")

keymap.set("n", "<leader><CR>", ":noh<CR>", { noremap = true })

keymap.set("n", "g1", ":tabn 1<CR>", { noremap = true, silent = true })
keymap.set("n", "g2", ":tabn 2<CR>", { noremap = true, silent = true })
keymap.set("n", "g3", ":tabn 3<CR>", { noremap = true, silent = true })
keymap.set("n", "g4", ":tabn 4<CR>", { noremap = true, silent = true })
keymap.set("n", "g5", ":tabn 5<CR>", { noremap = true, silent = true })

keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { noremap = true, silent = true })
keymap.set("n", "<leader>dN", vim.diagnostic.goto_prev, { noremap = true, silent = true })

local function organize_imports()
	local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = 0 })[1]

	client:exec_cmd({
		title = "organize_imports",
		command = "_typescript.organizeImports",
		arguments = {
			vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
		},
	}, { bufnr = vim.api.nvim_get_current_buf() })
end

keymap.set("n", "<leader>oi", organize_imports, { noremap = true, silent = true })
