-- Language support
return {
	{ "tpope/vim-endwise" },
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
}