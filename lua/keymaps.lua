vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>vs", ":vsplit<CR>")

keymap.set("n", "<leader><CR>", ":noh<CR>")

keymap.set("n", "<leader>1", ":tabn 1<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>2", ":tabn 2<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>3", ":tabn 3<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>4", ":tabn 4<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>5", ":tabn 5<CR>", { noremap = true, silent = true })

keymap.set("n", "<leader>`", ":tab Git<CR>", { noremap = true, silent = true })
