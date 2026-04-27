-- Snippets
return {
	{
		"SirVer/ultisnips",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<c-e>"
			vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
		end,
	},
	{ "ladislas/vim-snippets" },
}