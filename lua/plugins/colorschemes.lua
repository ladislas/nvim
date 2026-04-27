-- Colorschemes
return {
	{
		"morhetz/gruvbox",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_bold = 0
		end,
	},
	{ "arcticicestudio/nord-vim", lazy = false },
}