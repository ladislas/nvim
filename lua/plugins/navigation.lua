-- File tree navigation
return {
	{
		"scrooloose/nerdtree",
		config = function()
			vim.g.NERDTreeShowHidden = 0
			vim.g.NERDTreeQuitOnOpen = 0
			vim.g.NERDTreeUseSimpleIndicator = 1
			vim.g.NERDTreeShowLineNumbers = 1
			vim.g.NERDTreeChDirMode = 2
			vim.g.NERDTreeShowBookmarks = 0
			vim.g.NERDTreeIgnore = { "\\.hg", ".DS_Store" }
			vim.g.NERDTreeBookmarksFile = require("config.utils").create_and_expand(
				vim.g.cacheDir .. "/NERDTree/NERDTreeShowBookmarks"
			)
		end,
		keys = {
			{ "n", "<F2>", ":NERDTreeToggle<CR>" },
			{ "n", "<F3>", ":NERDTreeFind<CR>" },
		},
	},
	{ "Xuyuanp/nerdtree-git-plugin" },
}