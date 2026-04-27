-- Startup / dashboard
return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Ensure session directory exists
			require("config.utils").create_and_expand(vim.g.cacheDir .. "/sessions")

			dashboard.section.header.val = {
				"╔══════════════════════════════════╗",
				"║          nvim dashboard          ║",
				"╚══════════════════════════════════╝",
			}

			dashboard.section.mru.val = 5

			vim.keymap.set("n", "<F1>", ":Alpha<CR>", { silent = true })

			alpha.setup(dashboard.config)
		end,
	},
}