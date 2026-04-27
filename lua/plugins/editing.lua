-- Editing enhancements
return {
	{ "editorconfig/editorconfig-vim" },
	{ "jiangmiao/auto-pairs" },
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "x", "ga", "<Plug>(EasyAlign)" },
			{ "n", "ga", "<Plug>(EasyAlign)" },
		},
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-repeat" },
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "n", "<F5>", ":UndotreeToggle<CR>", silent = true },
		},
	},
}