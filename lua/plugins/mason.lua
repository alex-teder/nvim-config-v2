return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua-language-server",
				"typescript-language-server",
				"prettierd",
				"eslint_d",
				"stylua",
				"css-lsp",
				"html-lsp",
				"json-lsp",
				"pyright",
			},
		})
	end,
}
