return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local opts = {
			flavour = "mocha",
			no_bold = true,
			transparent_background = true,
			custom_highlights = function(colors)
				return {
					["@variable.member"] = { fg = colors.lavender },
					["@module"] = { fg = colors.lavender, style = { "italic" } },
					["@type.builtin"] = { fg = colors.yellow, style = { "italic" } },
					["@property"] = { fg = colors.lavender }, -- Same as TSField.
					["@constructor"] = { fg = colors.sapphire },
					["@keyword.operator"] = { link = "Operator" },
					["@keyword.export"] = { fg = colors.sky },
					["@tag"] = { fg = colors.mauve },
					["@tag.builtin"] = { fg = colors.mauve },
					["@tag.attribute"] = { fg = colors.teal, style = { "italic" } },
					["@tag.delimiter"] = { fg = colors.sky },
				}
			end,
		}
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin")
	end,
}
