return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "oxfmt" },
			typescriptreact = { "oxfmt" },
			javascript = { "oxfmt" },
			javascriptreact = { "oxfmt" },
			css = { "oxfmt" },
			html = { "oxfmt" },
			json = { "oxfmt" },
			jsonc = { "oxfmt" },
			yaml = { "oxfmt" },
			markdown = { "oxfmt" },
		},
	},
}
