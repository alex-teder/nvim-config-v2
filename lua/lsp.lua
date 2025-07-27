local servers = vim.fn.readdir(vim.fn.stdpath("config") .. "/lsp")
for _, name in ipairs(servers) do
	vim.lsp.enable(vim.fn.fnamemodify(name, ":r"))
end

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	root_markers = { ".git" },
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.keymap.set("n", "<leader><space>", function()
			vim.diagnostic.open_float({ border = "rounded", source = true })
		end, { silent = true, buffer = ev.buf })

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, { silent = true, buffer = ev.buf })

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = ev.buf })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = ev.buf })
	end,
})
