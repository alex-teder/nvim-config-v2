return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Add border to the diagnostic popup window
		vim.diagnostic.config({
			float = { border = "single" },
		})

		-- Add the border on hover and on signature help popup window
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
		}

		local servers = {
			["cssls"] = function()
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
			["graphql"] = function()
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["astro"] = function()
				lspconfig["astro"].setup({
					capabilities = capabilities,
					filetypes = { "astro" },
				})
			end,
			["tailwindcss"] = function()
				lspconfig["tailwindcss"].setup({
					capabilities = capabilities,
					filetypes = { "html", "astro" },
				})
			end,
			["emmet_language_server"] = function()
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
			["vue_ls"] = function()
				-- NOTE: this lspconfig name is different from Mason
				lspconfig["volar"].setup({
					capabilities = capabilities,
					filetypes = { "javascript", "typescript", "vue" },
				})
			end,
			["ts_ls"] = function()
				local plugins = {}

				if require("mason-registry").get_package("vue-language-server"):is_installed() then
					table.insert(plugins, {
						name = "@vue/typescript-plugin",
						location = vim.fn.stdpath("data")
							.. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
						languages = { "vue", "javascript", "typescript" },
					})
				end

				lspconfig["ts_ls"].setup({
					capabilities = capabilities,
					init_options = {
						plugins = plugins,
					},
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
					},
				})
			end,
		}

		local ensure_installed = {
			"ts_ls",
			"html",
			"cssls",
			"lua_ls",
			"graphql",
			"emmet_language_server",
			"pyright",
			"vue_ls",
			"astro",
			"rust_analyzer",
			"tailwindcss",
			"jsonls",
		}

		mason_tool_installer.setup({
			ensure_installed = { "prettierd", "prettier", "stylua", "eslint_d" },
		})

		mason_lspconfig.setup({
			automatic_enable = false,
			ensure_installed = ensure_installed,
		})

		local function setup_default_handlers(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
				handlers = handlers,
			})
		end

		-- do the thing
		for _, server_name in pairs(ensure_installed) do
			if servers[server_name] then
				servers[server_name]()
			else
				setup_default_handlers(server_name)
			end
		end

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
	end,
}
