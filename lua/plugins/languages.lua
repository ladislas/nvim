-- Language support
return {
	{ "tpope/vim-endwise" },
	{
		"sheerun/vim-polyglot",
		config = function()
			vim.g.polyglot_disabled = { "markdown", "c", "cpp", "h" }
		end,
	},
	{ "octol/vim-cpp-enhanced-highlight", ft = { "cpp", "c", "h" } },
	{ "keith/swift.vim" },
	{ "chase/vim-ansible-yaml" },
	{
		"vim-pandoc/vim-pandoc",
		ft = { "markdown", "pandoc", "pandoc.markdown" },
		config = function()
			vim.g["pandoc#formatting#equalprg"] = "pandoc -t gfm --wrap=none"
		end,
	},
	{
		"vim-pandoc/vim-pandoc-syntax",
		ft = { "markdown", "pandoc", "pandoc.markdown" },
		config = function()
			vim.g["pandoc#syntax#conceal#use"] = 0
			vim.g["pandoc#syntax#conceal#blacklist"] = { "block", "codeblock_start", "codeblock_delim" }
			vim.g["pandoc#syntax#conceal#cchar_overrides"] = { li = "*" }
		end,
	},
	{
		"shime/vim-livedown",
		ft = { "markdown", "pandoc", "pandoc.markdown" },
		config = function()
			vim.g.livedown_autorun = 0
			vim.g.livedown_open = 1
			vim.g.livedown_port = 1337
			vim.g.livedown_browser = "chrome"
		end,
		keys = {
			{ "n", "<leader>gm", ":call LivedownPreview()<CR>" },
		},
	},
}