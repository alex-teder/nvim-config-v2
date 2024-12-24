vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>vs", ":vsplit<CR>")

keymap.set("n", "<leader><CR>", ":noh<CR>")

keymap.set("n", "g1", ":tabn 1<CR>", { noremap = true, silent = true })
keymap.set("n", "g2", ":tabn 2<CR>", { noremap = true, silent = true })
keymap.set("n", "g3", ":tabn 3<CR>", { noremap = true, silent = true })
keymap.set("n", "g4", ":tabn 4<CR>", { noremap = true, silent = true })
keymap.set("n", "g5", ":tabn 5<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-J>", "<C-e>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-y>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dN", vim.diagnostic.goto_prev, { noremap = true, silent = true })
