vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- =======================================
-- Options
-- =======================================
vim.o.number = true
vim.o.cursorline = true
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes:1"
vim.o.termguicolors = true

vim.o.confirm = true
vim.o.updatetime = 100
vim.o.hlsearch = true
vim.o.autoread = true
vim.o.incsearch = true

-- Tabs
vim.o.tabstop = 4

-- =======================================
-- Keymaps
-- =======================================

-- Search
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- Save
vim.keymap.set("n", "<leader>w", function()
	vim.lsp.buf.format()
	vim.cmd("w")
end, { desc = "Format Save" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Save" })

-- Buffers
vim.keymap.set("n", "<S-l>", ":bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer" })

-- Window Resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

-- Grab Lines (Visual Mode)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })
