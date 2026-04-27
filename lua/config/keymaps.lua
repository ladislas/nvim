local utils = require("config.utils")

local map = vim.keymap.set

-- Basic function calls
map("n", "<leader>f$", function()
	utils.strip_trailing_whitespace()
end)
map("n", "<leader>fef", function()
	utils.preserve_cursor_position("normal gg=G")
end)

-- Quick save
map("n", "<leader>w", ":w<cr>")

-- Add newline with return key
map("n", "<cr>", "o<esc>")

-- Quicker ESC
map("i", "jj", "<esc>")

-- Save with sudo
map("c", "w!!", "%!sudo tee > /dev/null %")

-- Sort text
map("v", "<leader>ss", ":sort<cr>")

-- Remap arrow keys
map("n", "<down>", ":tabprev<cr>")
map("n", "<left>", ":bprev<cr>")
map("n", "<right>", ":bnext<cr>")
map("n", "<up>", ":tabnext<cr>")

-- Windows/Buffers motion keys
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")
map("n", "<leader>s", "<c-w>s")
map("n", "<leader>v", "<c-w>v<c-w>l")
map("n", "<leader>vsa", ":vert sba<cr>")

-- Change cursor position in insert mode
map("i", "<c-h>", "<left>")
map("i", "<c-j>", "<down>")
map("i", "<c-k>", "<up>")
map("i", "<c-l>", "<right>")

-- Sane regex search
map("n", "/", "/\\v")
map("v", "/", "/\\v")
map("n", "?", "?\\v")
map("v", "?", "?\\v")

-- Turn search highlight on and off
map("n", "<bs>", ":set hlsearch! hlsearch?<cr>")

-- Screen line scroll
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })

-- Reselect visual block after indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Reselect last paste
map("n", "gp", function()
	return "`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]"
end, { expr = true })

-- Make Y consistent with C and D
map("n", "Y", "y$")

-- Hide annoying quit message
map("n", "<c-c>", "<c-c>:echo<cr>")

-- Window killer
map("n", "Q", function()
	utils.close_window_or_kill_buffer()
end, { silent = true })

-- Quick buffer open
map("n", "gb", ":ls<cr>:e #")

-- Tab shortcuts
map("", "<leader>tn", ":tabnew<cr>")
map("", "<leader>tc", ":tabclose<cr>")

-- Spell check on/off
map("n", "<leader>sp", ":set spell!<cr>", { silent = true })