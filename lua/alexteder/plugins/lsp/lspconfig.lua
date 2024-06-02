return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local keymap = vim.keymap
				local opts = { buffer = ev.buf, silent = true }
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
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

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				vim.keymap.set(
					"n",
					"<leader><space>",
					":lua vim.diagnostic.open_float()<CR>",
					{ silent = true, desc = "Show diagnostics message" }
				)
			end,
		})

		-- Add the border on hover and on signature help popup window
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
		}

		-- Add border to the diagnostic popup window
		vim.diagnostic.config({
			float = { border = "single" },
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					handlers = handlers,
				})
			end,
			["cssls"] = function()
				-- configure css server
				lspconfig["cssls"].setup({
					capabilities = capabilities,
					settings = {
						css = { validate = true, lint = {
							unknownAtRules = "ignore",
						} },
						scss = { validate = true, lint = {
							unknownAtRules = "ignore",
						} },
						less = { validate = true, lint = {
							unknownAtRules = "ignore",
						} },
					},
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["emmet_language_server"] = function()
				-- configure emmet language server
				lspconfig["emmet_language_server"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
