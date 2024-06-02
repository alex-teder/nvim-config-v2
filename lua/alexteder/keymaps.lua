vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Switch to Normal mode" })

-- when scrolling keep cursor in the center
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical split" })
