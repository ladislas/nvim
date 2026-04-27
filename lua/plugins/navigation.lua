-- File tree navigation
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
					filtered_items = {
						visible = false,
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_by_name = {
							".hg",
							".DS_Store",
						},
					},
					window = {
						mappings = {
							["<cr>"] = "open",
						},
					},
				},
				window = {
					width = 30,
					mappings = {
						["h"] = "toggle_hidden",
					},
				},
			})

			vim.keymap.set("n", "<F2>", ":Neotree toggle<CR>", { silent = true })
			vim.keymap.set("n", "<F3>", ":Neotree reveal<CR>", { silent = true })
		end,
	},
}