-- Startup / dashboard
return {
	{
		"mhinz/vim-startify",
		cmd = "Startify",
		config = function()
			vim.g.startify_session_dir = require("config.utils").create_and_expand(
				vim.g.cacheDir .. "/sessions"
			)
			vim.g.startify_change_to_vcs_root = 1
			vim.g.startify_show_sessions = 1
		end,
		keys = {
			{ "n", "<F1>", ":Startify<cr>" },
		},
	},
}