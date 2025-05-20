return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap

				opts.desc = "Show LSP references"
				keymap.set("n", "gr", vim.lsp.buf.references, opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader><space>", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
			end,
		})

		-- TODO: move this
		-- Add border to the diagnostic popup window
		vim.diagnostic.config({
			float = { border = "single" },
		})
	end,
}
