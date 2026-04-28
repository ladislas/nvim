-- Fuzzy finder (fzf-lua)
return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		keys = {
			{ "n", "<leader>ff", ":FzfLua files<CR>", silent = true, desc = "Find files" },
			{ "n", "<leader>fg", ":FzfLua live_grep<CR>", silent = true, desc = "Live grep" },
			{ "n", "<leader>fb", ":FzfLua buffers<CR>", silent = true, desc = "Find buffers" },
			{ "n", "<leader>fr", ":FzfLua registers<CR>", silent = true, desc = "Yank history / registers" },
		},
		config = function()
			require("fzf-lua").setup({
				-- Default previewer for most pickers
				default_previewer = "bat",
			})
		end,
	},
}