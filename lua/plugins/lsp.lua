-- LSP configuration (nvim-lspconfig + mason)
return {
	-- LSP server manager
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_lsp = require("cmp_nvim_lsp")

			-- Enhanced capabilities from nvim-cmp
			local capabilities = cmp_lsp.default_capabilities()

			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			-- Diagnostic signs
			local signs = {
				Error = "✘",
				Warn = "▲",
				Hint = "⚑",
				Info = "»",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- LSP keymaps (set on attach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "goto definition")
					map("gr", vim.lsp.buf.references, "references")
					map("gD", vim.lsp.buf.declaration, "goto declaration")
					map("gi", vim.lsp.buf.implementation, "goto implementation")
					map("K", vim.lsp.buf.hover, "hover documentation")
					map("<leader>rn", vim.lsp.buf.rename, "rename")
					map("<leader>ca", vim.lsp.buf.code_action, "code action")
					map("<leader>d", vim.diagnostic.open_float, "line diagnostics")
					map("[d", vim.diagnostic.goto_prev, "previous diagnostic")
					map("]d", vim.diagnostic.goto_next, "next diagnostic")
				end,
			})

			-- mason-lspconfig bridge
			require("mason-lspconfig").setup({
				handlers = {
					-- Default handler for all servers
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
}