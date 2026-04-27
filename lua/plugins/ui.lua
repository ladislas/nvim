-- UI enhancements
return {
	{
		"vim-airline/vim-airline",
		lazy = false,
		config = function()
			vim.g.airline_powerline_fonts = 0
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#whitespace#mixed_indent_algo"] = 2
		end,
	},
	{
		"zhaocai/GoldenView.Vim",
		config = function()
			vim.g.goldenview__enable_default_mapping = 0
		end,
		keys = {
			{ "n", "<F4>", "<Plug>ToggleGoldenViewAutoResize" },
		},
	},
	{
		"luochen1990/rainbow",
		lazy = false,
		config = function()
			vim.g.rainbow_active = 1
			vim.g.rainbow_conf = {
				ctermfgs = { "245", "142", "109", "175", "167", "208", "214", "223" },
			}
		end,
	},
}