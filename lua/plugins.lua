-- Plugin specifications for lazy.nvim
local plugins = {
	-- Colorschemes
	{
		"morhetz/gruvbox",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_bold = 0
		end,
	},
	{ "arcticicestudio/nord-vim", lazy = false },

	-- UI
	{
		"vim-airline/vim-airline",
		lazy = false,
		config = function()
			vim.g.airline_powerline_fonts = 0
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#whitespace#mixed_indent_algo"] = 2
		end,
	},
	{
		"zhaocai/GoldenView.Vim",
		config = function()
			vim.g.goldenview__enable_default_mapping = 0
		end,
		keys = {
			{ "n", "<F4>", "<Plug>ToggleGoldenViewAutoResize" },
		},
	},
	{
		"luochen1990/rainbow",
		lazy = false,
		config = function()
			vim.g.rainbow_active = 1
			vim.g.rainbow_conf = {
				ctermfgs = { "245", "142", "109", "175", "167", "208", "214", "223" },
			}
		end,
	},
	{
		"thiagoalessio/rainbow_levels.vim",
		config = function()
			vim.g.rainbow_levels = {
				{ ctermfg = 142, guifg = "#b8bb26" },
				{ ctermfg = 108, guifg = "#8ec07c" },
				{ ctermfg = 109, guifg = "#83a598" },
				{ ctermfg = 175, guifg = "#d3869b" },
				{ ctermfg = 167, guifg = "#fb4934" },
				{ ctermfg = 208, guifg = "#fe8019" },
				{ ctermfg = 214, guifg = "#fabd2f" },
				{ ctermfg = 223, guifg = "#ebdbb2" },
				{ ctermfg = 245, guifg = "#928374" },
			}
		end,
	},

	-- Buffers
	{ "duff/vim-bufonly" },
	{ "qpkorr/vim-bufkill" },

	-- Startup
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

	-- Editing
	{ "editorconfig/editorconfig-vim" },
	{
		"kristijanhusak/vim-multiple-cursors",
		config = function()
			vim.cmd([[
				function! Multiple_cursors_before()
					if exists('*deoplete#custom#buffer_option')
						call deoplete#custom#buffer_option('auto_complete', v:false)
					endif
				endfunction
				function! Multiple_cursors_after()
					if exists('*deoplete#custom#buffer_option')
						call deoplete#custom#buffer_option('auto_complete', v:true)
					endif
				endfunction
			]])
		end,
	},
	{ "jiangmiao/auto-pairs" },
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "x", "ga", "<Plug>(EasyAlign)" },
			{ "n", "ga", "<Plug>(EasyAlign)" },
		},
	},
	{
		"tpope/vim-surround",
	},
	{ "tpope/vim-commentary" },
	{ "tpope/vim-repeat" },
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "n", "<F5>", ":UndotreeToggle<CR>", silent = true },
		},
	},

	-- Language support
	{ "tpope/vim-endwise" },
	{
		"sheerun/vim-polyglot",
		config = function()
			vim.g.polyglot_disabled = { "markdown", "c", "cpp", "h" }
		end,
	},
	{ "octol/vim-cpp-enhanced-highlight", ft = { "cpp", "c", "h" } },
	{ "keith/swift.vim" },
	{ "chase/vim-ansible-yaml" },
	{
		"vim-pandoc/vim-pandoc",
		ft = { "markdown", "pandoc", "pandoc.markdown" },
		config = function()
			vim.g["pandoc#formatting#equalprg"] = "pandoc -t gfm --wrap=none"
		end,
	},
	{
		"vim-pandoc/vim-pandoc-syntax",
		ft = { "markdown", "pandoc", "pandoc.markdown" },
		config = function()
			vim.g["pandoc#syntax#conceal#use"] = 0
			vim.g["pandoc#syntax#conceal#blacklist"] = { "block", "codeblock_start", "codeblock_delim" }
			vim.g["pandoc#syntax#conceal#cchar_overrides"] = { li = "*" }
		end,
	},
	{
		"shime/vim-livedown",
		ft = { "markdown", "pandoc", "pandoc.markdown" },
		config = function()
			vim.g.livedown_autorun = 0
			vim.g.livedown_open = 1
			vim.g.livedown_port = 1337
			vim.g.livedown_browser = "chrome"
		end,
		keys = {
			{ "n", "<leader>gm", ":call LivedownPreview()<CR>" },
		},
	},

	-- Autocompletion & Snippets
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

	-- Denite
	{
		"Shougo/denite.nvim",
		config = function()
			vim.call("denite#custom#option", "default", "prompt", ">")
			vim.call("denite#custom#map", "insert", "<C-j>", "<denite:move_to_next_line>", "noremap")
			vim.call("denite#custom#map", "insert", "<C-k>", "<denite:move_to_previous_line>", "noremap")
		end,
		keys = {
			{ "n", "<space>y", ":<C-u>Denite neoyank -direction=dynamictop -buffer-name=yanks<cr>", silent = true },
			{ "n", "<space>t", ":<C-u>Denite -direction=dynamictop -buffer-name=files file<cr>", silent = true },
			{ "n", "<space>l", ":<C-u>Denite -direction=dynamictop -buffer-name=line line<cr>", silent = true },
			{ "n", "<space>b", ":<C-u>Denite -direction=dynamictop -buffer-name=buffers buffer<cr>", silent = true },
		},
	},
	{ "Shougo/neoyank.vim" },

	-- Navigation
	{
		"scrooloose/nerdtree",
		config = function()
			vim.g.NERDTreeShowHidden = 0
			vim.g.NERDTreeQuitOnOpen = 0
			vim.g.NERDTreeUseSimpleIndicator = 1
			vim.g.NERDTreeShowLineNumbers = 1
			vim.g.NERDTreeChDirMode = 2
			vim.g.NERDTreeShowBookmarks = 0
			vim.g.NERDTreeIgnore = { "\\.hg", ".DS_Store" }
			vim.g.NERDTreeBookmarksFile = require("config.utils").create_and_expand(
				vim.g.cacheDir .. "/NERDTree/NERDTreeShowBookmarks"
			)
		end,
		keys = {
			{ "n", "<F2>", ":NERDTreeToggle<CR>" },
			{ "n", "<F3>", ":NERDTreeFind<CR>" },
		},
	},
	{ "Xuyuanp/nerdtree-git-plugin" },

	-- Source Control
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.g.gitgutter_realtime = 0
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

require("lazy").setup(plugins)