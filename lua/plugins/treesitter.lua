-- Treesitter: syntax highlighting, selection, indentation
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- Install parsers
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"vim",
				"vimdoc",
				"yaml",
			})

			-- Enable treesitter highlighting
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable treesitter-based indentation (experimental)
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_indent", { clear = true }),
				callback = function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}