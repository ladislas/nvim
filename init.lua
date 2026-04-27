-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load config modules
require("config.utils")
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugins via lazy.nvim
require("config.lazy")

-- Final setup
vim.cmd("colorscheme gruvbox")
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")