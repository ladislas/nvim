-- Plugin specifications for lazy.nvim
-- Migrated from vim-plug Plug declarations

local plugins = {
	-- Colorschemes
	{ "morhetz/gruvbox", lazy = false, priority = 1000 },
	{ "arcticicestudio/nord-vim", lazy = false },

	-- UI
	{ "vim-airline/vim-airline", lazy = false },
	{ "zhaocai/GoldenView.Vim", keys = "<Plug>ToggleGoldenViewAutoResize" },
	{ "luochen1990/rainbow", lazy = false },
	{ "thiagoalessio/rainbow_levels.vim" },

	-- Buffers
	{ "duff/vim-bufonly" },
	{ "qpkorr/vim-bufkill" },

	-- Startup
	{ "mhinz/vim-startify", cmd = "Startify" },

	-- Editing
	{ "editorconfig/editorconfig-vim" },
	{ "kristijanhusak/vim-multiple-cursors" },
	{ "jiangmiao/auto-pairs" },
	{ "junegunn/vim-easy-align" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-repeat" },
	{ "mbbill/undotree", cmd = "UndotreeToggle", keys = "<F5>" },

	-- Language support
	{ "tpope/vim-endwise" },
	{ "sheerun/vim-polyglot" },
	{ "octol/vim-cpp-enhanced-highlight", ft = { "cpp", "c", "h" } },
	{ "keith/swift.vim" },
	{ "chase/vim-ansible-yaml" },
	{ "vim-pandoc/vim-pandoc", ft = { "markdown", "pandoc", "pandoc.markdown" } },
	{ "vim-pandoc/vim-pandoc-syntax", ft = { "markdown", "pandoc", "pandoc.markdown" } },
	{ "shime/vim-livedown", ft = { "markdown", "pandoc", "pandoc.markdown" } },

	-- Autocompletion & Snippets
	{ "autozimu/LanguageClient-neovim", branch = "next", build = "bash install.sh" },
	{ "Shougo/deoplete.nvim", build = ":UpdateRemotePlugins" },
	{ "Valloric/YouCompleteMe", build = "./install.py --clang-completer --clangd-completer", ft = { "cpp", "c", "h", "ino" } },
	{ "SirVer/ultisnips" },
	{ "tenfyzhong/CompleteParameter.vim" },
	{ "ladislas/vim-snippets" },

	-- Denite
	{ "Shougo/denite.nvim" },
	{ "Shougo/neoyank.vim" },

	-- Navigation
	{ "scrooloose/nerdtree" },
	{ "Xuyuanp/nerdtree-git-plugin" },

	-- Source Control
	{ "airblade/vim-gitgutter" },
	{ "tpope/vim-fugitive" },
}

require("lazy").setup(plugins)