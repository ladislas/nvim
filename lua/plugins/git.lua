-- Source control / Git
return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = require("gitsigns")
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							return "]h"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[h", function()
						if vim.wo.diff then
							return "[h"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
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