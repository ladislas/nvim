-- Denite fuzzy finder & yank history
return {
	{
		"Shougo/denite.nvim",
		config = function()
			vim.call("denite#custom#option", "default", "prompt", ">")
			vim.call("denite#custom#map", "insert", "<C-j>", "<denite:move_to_next_line>", "noremap")
			vim.call("denite#custom#map", "insert", "<C-k>", "<denite:move_to_previous_line>", "noremap")
		end,
		keys = {
			{ "n", "<space>y", ":<C-u>Denite neoyank -direction=dynamictop -buffer-name=yanks<cr>", silent = true },
			{ "n", "<space>t", ":<C-u>Denite -direction=dynamictop -buffer-name=files file<cr>", silent = true },
			{ "n", "<space>l", ":<C-u>Denite -direction=dynamictop -buffer-name=line line<cr>", silent = true },
			{ "n", "<space>b", ":<C-u>Denite -direction=dynamictop -buffer-name=buffers buffer<cr>", silent = true },
		},
	},
	{ "Shougo/neoyank.vim" },
}