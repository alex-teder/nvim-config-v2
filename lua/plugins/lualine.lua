local flavour = "mocha"
local C = require("catppuccin.palettes").get_palette(flavour)

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		disabled_filetypes = {
			"oil",
			"NvimTree",
			statusline = {},
			winbar = {},
		},
		options = {
			refresh = { statusline = 32 },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"diff",
				"diagnostics",
			},
			lualine_c = {
				{
					"filename",
					file_status = true,
					symbols = { modified = "●" },
					separator = { left = "", right = "" },
				},
				{
					"branch",
					color = { fg = C.overlay0 },
					padding = { left = 0, right = 1 },
				},
			},
			lualine_x = {
				"encoding",
				{
					"lsp_status",
					icon = "",
					padding = { left = 0, right = 1 },
					symbols = {
						spinner = { "", "", "", "", "", "" },
						done = "",
					},
				},
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
