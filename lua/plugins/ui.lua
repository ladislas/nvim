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
	{
		"thiagoalessio/rainbow_levels.vim",
		config = function()
			vim.g.rainbow_levels = {
				{ ctermfg = 142, guifg = "#b8bb26" },
				{ ctermfg = 108, guifg = "#8ec07c" },
				{ ctermfg = 109, guifg = "#83a598" },
				{ ctermfg = 175, guifg = "#d3869b" },
				{ ctermfg = 167, guifg = "#fb4934" },
				{ ctermfg = 208, guifg = "#fe8019" },
				{ ctermfg = 214, guifg = "#fabd2f" },
				{ ctermfg = 223, guifg = "#ebdbb2" },
				{ ctermfg = 245, guifg = "#928374" },
			}
		end,
	},
}