local catppuccin = {}
local flavour = "mocha"
local C = require("catppuccin.palettes").get_palette(flavour)
local O = require("catppuccin").options
local transparent_bg = O.transparent_background and "NONE" or C.mantle

catppuccin.normal = {
	a = { bg = "#80abf1", fg = C.mantle, gui = "bold" },
	b = { bg = C.surface0, fg = C.blue },
	c = { bg = transparent_bg, fg = C.text },
}

catppuccin.insert = {
	a = { bg = C.green, fg = C.base, gui = "bold" },
	b = { bg = C.surface0, fg = C.green },
}

catppuccin.terminal = {
	a = { bg = C.green, fg = C.base, gui = "bold" },
	b = { bg = C.surface0, fg = C.green },
}

catppuccin.command = {
	a = { bg = C.peach, fg = C.base, gui = "bold" },
	b = { bg = C.surface0, fg = C.peach },
}

catppuccin.visual = {
	a = { bg = C.mauve, fg = C.base, gui = "bold" },
	b = { bg = C.surface0, fg = C.mauve },
}

catppuccin.replace = {
	a = { bg = C.red, fg = C.base, gui = "bold" },
	b = { bg = C.surface0, fg = C.red },
}

catppuccin.inactive = {
	a = { bg = transparent_bg, fg = C.blue },
	b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
	c = { bg = transparent_bg, fg = C.overlay0 },
}

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = true,
			theme = catppuccin,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				"NvimTree",
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "diff", "diagnostics" },
			lualine_c = { { "filename", file_status = true, symbols = { modified = "●" } } },
			lualine_x = { "encoding", "filetype", "filesize" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
}
