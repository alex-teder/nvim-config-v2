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
					padding = { left = 0, right = 0 },
					fmt = function(str)
						local filename = vim.fn.expand("%:t") -- Current filename
						local filename_len = #filename
						--
						-- Adjust max_length based on filename length
						local available_space = vim.o.columns -- Total statusline space
						local other_components = 60 -- Space for other statusline components
						local min_desired_length = 9

						local max_length =
							math.max(min_desired_length, available_space - other_components - filename_len)
						if #str > max_length then
							return str:sub(1, max_length - 3) .. "..."
						end
						return str
					end,
				},
			},
			lualine_x = {
				{
					"lsp_status",
					icon = "",
					padding = { left = 0, right = 1 },
					symbols = {
						spinner = { "", "", "", "", "", "" },
						done = "",
					},
					ignore_lsp = { "Augment Server" },
				},
			},
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
	},
}
