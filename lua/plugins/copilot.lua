return {
	"zbirenbaum/copilot.lua",
	enabled = true,
	-- event = { "InsertEnter" },
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<tab>",
				},
			},
			panel = { enabled = false },
			nes = { enabled = false },
		})
	end,
}
