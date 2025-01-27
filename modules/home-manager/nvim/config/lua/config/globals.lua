vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.mouse = "a"

vim.keymap.set("n", "<CR>", ":noh<CR><CR>", { noremap = true, silent = true })
