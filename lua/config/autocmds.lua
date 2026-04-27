local augroup = vim.api.nvim_create_augroup("config", { clear = true })

-- Highlight current line only in active window
vim.api.nvim_create_autocmd("WinLeave", {
	group = augroup,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
vim.api.nvim_create_autocmd("WinEnter", {
	group = augroup,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- Comment string for C-style languages
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "c", "cpp", "cs", "java" },
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

-- Markdown filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup,
	pattern = { "*.md", "*.markdown" },
	callback = function()
		vim.bo.filetype = "pandoc.markdown"
	end,
})