vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>vs", ":vsplit<CR>")

keymap.set("n", "<leader><CR>", ":noh<CR>")
