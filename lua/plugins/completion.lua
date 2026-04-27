-- Autocompletion, snippets & language client
return {
	{
		"autozimu/LanguageClient-neovim",
		branch = "next",
		build = "bash install.sh",
	},
	{
		"Shougo/deoplete.nvim",
		build = ":UpdateRemotePlugins",
		config = function()
			vim.g.deoplete_enable_at_startup = 0

			vim.api.nvim_create_autocmd("InsertEnter", {
				callback = function()
					vim.fn["deoplete#enable"]()
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "h", "c", "cpp" },
				callback = function()
					vim.call("deoplete#custom#buffer_option", "auto_complete", false)
				end,
			})

			local function check_back_space()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
			end

			vim.keymap.set("i", "<Tab>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-n>"
				elseif check_back_space() then
					return "<Tab>"
				else
					return vim.fn["deoplete#mappings#manual_complete"]()
				end
			end, { expr = true, silent = true })

			vim.keymap.set("i", "<S-Tab>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-p>"
				elseif check_back_space() then
					return "<Tab>"
				else
					return vim.fn["deoplete#mappings#manual_complete"]()
				end
			end, { expr = true, silent = true })
		end,
	},
	{
		"Valloric/YouCompleteMe",
		build = "./install.py --clang-completer --clangd-completer",
		ft = { "cpp", "c", "h", "ino" },
		config = function()
			vim.g.ycm_key_list_previous_completion = { "<S-TAB>", "<Up>" }
			vim.g.ycm_key_list_select_completion = { "<TAB>", "<Down>" }
			vim.g.ycm_error_symbol = ">>"
			vim.g.ycm_warning_symbol = "!!"
			vim.g.ycm_use_clangd = 0
			vim.g.ycm_goto_buffer_command = "vertical-split"
			vim.g.ycm_autoclose_preview_window_after_insertion = 1
		end,
	},
	{
		"SirVer/ultisnips",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<c-e>"
			vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
		end,
	},
	{
		"tenfyzhong/CompleteParameter.vim",
		config = function()
			vim.keymap.set("i", "(", function()
				return vim.fn["complete_parameter#pre_complete"]("()")
			end, { expr = true, silent = true })
			vim.keymap.set("s", "<c-j>", "<Plug>(complete_parameter#goto_next_parameter)")
			vim.keymap.set("i", "<c-j>", "<Plug>(complete_parameter#goto_next_parameter)")
			vim.keymap.set("s", "<c-k>", "<Plug>(complete_parameter#goto_previous_parameter)")
			vim.keymap.set("i", "<c-k>", "<Plug>(complete_parameter#goto_previous_parameter)")
		end,
	},
	{ "ladislas/vim-snippets" },
}