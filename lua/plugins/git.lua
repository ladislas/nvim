-- Source control / Git
return {
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.g.gitgutter_realtime = 0
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", ":Gstatus<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gc", ":Gcommit<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gb", ":Gblame<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gl", ":Glog<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gr", ":Gremove<CR>", { silent = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("fugitive", { clear = true }),
				pattern = "gitcommit",
				callback = function()
					vim.keymap.set("n", "U", ":Git checkout -- <C-r><C-g><CR>", { buffer = true })
				end,
			})
			vim.api.nvim_create_autocmd("BufReadPost", {
				group = vim.api.nvim_create_augroup("fugitive_buf", { clear = true }),
				pattern = "fugitive://*",
				callback = function()
					vim.bo.bufhidden = "delete"
				end,
			})
		end,
	},
}