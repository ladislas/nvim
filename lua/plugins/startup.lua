-- Startup / dashboard
return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.thumbnails.dashboard")

			local session_dir = require("config.utils").create_and_expand(
				vim.g.cacheDir .. "/sessions"
			)

			dashboard.section_header.val = {
				"╔══════════════════════════════════╗",
				"║          nvim dashboard          ║",
				"╚══════════════════════════════════╝",
			}

			-- Recent files
			dashboard.section_mru.val = 5

			-- Session support: keymaps to save/restore sessions
			vim.keymap.set("n", "<F1>", ":Alpha<CR>", { silent = true })

			alpha.setup(dashboard.config)
		end,
	},
}