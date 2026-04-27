-- Editing enhancements
return {
	{ "editorconfig/editorconfig-vim" },
	{
		"kristijanhusak/vim-multiple-cursors",
		config = function()
			vim.cmd([[
				function! Multiple_cursors_before()
					if exists('*deoplete#custom#buffer_option')
						call deoplete#custom#buffer_option('auto_complete', v:false)
					endif
				endfunction
				function! Multiple_cursors_after()
					if exists('*deoplete#custom#buffer_option')
						call deoplete#custom#buffer_option('auto_complete', v:true)
					endif
				endfunction
			]])
		end,
	},
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