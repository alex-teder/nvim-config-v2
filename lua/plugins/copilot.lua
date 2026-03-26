return {
	"zbirenbaum/copilot.lua",
	event = { "InsertEnter" },
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = false,
			},
			nes = {
				enabled = true,
				keymap = {},
			},
		})
	end,
}
