local M = {}

function M.preserve_cursor_position(command)
	local save_search = vim.fn.getreg("/")
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")

	vim.cmd(command)

	vim.fn.setreg("/", save_search)
	vim.fn.cursor(line, col)
end

function M.strip_trailing_whitespace()
	M.preserve_cursor_position("%s/\\s\\+$//e")
end

function M.create_and_expand(path)
	local expanded = vim.fn.expand(path)
	if vim.fn.isdirectory(expanded) == 0 then
		vim.fn.mkdir(expanded, "p")
	end
	return expanded
end

function M.close_window_or_kill_buffer()
	local current_buf = vim.fn.bufnr("%")
	local windows_to_this_buffer = 0
	for i = 1, vim.fn.winnr("$") do
		if vim.fn.winbufnr(i) == current_buf then
			windows_to_this_buffer = windows_to_this_buffer + 1
		end
	end

	if vim.fn.matchstr(vim.fn.expand("%"), "NERD") == "NERD" then
		vim.cmd("wincmd c")
		return
	end

	if windows_to_this_buffer > 1 then
		vim.cmd("wincmd c")
	else
		vim.cmd("bdelete")
	end
end

return M