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

		local ensure_installed = {
			"ts_ls",
			"html",
			"cssls",
			"lua_ls",
			"graphql",
			"emmet_language_server",
			"pyright",
			"vue_ls",
			"rust_analyzer",
		}

		mason_lspconfig.setup({
			automatic_enable = false, -- hack
			ensure_installed = ensure_installed,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd",
				"stylua",
				"eslint_d",
			},
		})

		-- Add the border on hover and on signature help popup window
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
		}

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local function setup_default_handlers(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
				handlers = handlers,
			})
		end

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

		-- do the thing
		for _, server_name in pairs(ensure_installed) do
			if servers[server_name] then
				servers[server_name]()
			else
				setup_default_handlers(server_name)
			end
		end
	end,
}
