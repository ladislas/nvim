-- UI enhancements
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			-- Custom whitespace component (matches airline's mixed_indent_algo = 2)
			local function whitespace()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				local mixed_indent = false
				local trailing_ws = false
				for _, line in ipairs(lines) do
					local leading = line:match("^(%s+)")
					if leading then
						if leading:match("\t") and leading:match(" ") then
							mixed_indent = true
						end
					end
					if line:match("%s$") then
						trailing_ws = true
					end
				end
				local parts = {}
				if mixed_indent then
					table.insert(parts, "mix:")
				end
				if trailing_ws then
					table.insert(parts, "trail:")
				end
				return table.concat(parts, " ")
			end

			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "auto",
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { whitespace, "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = { "buffers" },
					lualine_z = { "tabs" },
				},
				extensions = {},
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					rainbow_delimiters.strategy["global"],
				},
				query = {
					[""] = "rainbow-delimiters",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}