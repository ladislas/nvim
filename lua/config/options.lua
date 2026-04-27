local utils = require("config.utils")

-- Leader
vim.g.mapleader = ","

-- Global variables
vim.g.nvimDir = "$HOME/.config/nvim"
local cacheDir = utils.create_and_expand(vim.g.nvimDir .. "/.cache")
vim.g.cacheDir = cacheDir

-- Basic
vim.opt.mouse = "a"
-- note: mousehide was removed in Neovim; cursor hides by default when typing

vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.nrformats:remove("octal")

vim.opt.spelllang = { "en_us", "fr" }

vim.opt.hidden = true
vim.opt.autowrite = true
vim.opt.autoread = true

vim.opt.modeline = true
vim.opt.modelines = 5

vim.opt.backspace = { "indent", "eol", "start" }

vim.opt.clipboard:append("unnamedplus")

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Backup
vim.opt.history = 1000
vim.opt.undolevels = 1000

vim.opt.undodir = utils.create_and_expand(cacheDir .. "/undo")
vim.opt.undofile = true

vim.opt.backupdir = utils.create_and_expand(cacheDir .. "/backup")
vim.opt.backup = true

vim.opt.directory = utils.create_and_expand(cacheDir .. "/swap")
vim.opt.swapfile = true

-- UI
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.scrolloff = 10
vim.opt.laststatus = 2
vim.opt.showmode = false

vim.opt.cursorline = true

vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.shiftround = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "•" }

vim.opt.linebreak = true
vim.opt.showbreak = "↪ "

vim.opt.showmatch = true
vim.opt.matchtime = 2

vim.opt.wildmenu = true
vim.opt.wildmode = { "list", "full" }
vim.opt.wildignorecase = true
vim.opt.wildignore:append({ "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.idea/*", "*/.DS_Store" })

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.foldenable = false
vim.opt.background = "dark"