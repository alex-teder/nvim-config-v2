return {
	"crispgm/nvim-tabline",
	opts = {
		modify_indicator = " ●",
		brackets = { " ", "" },
		no_name = "...",
		fnamemodify = function(buf)
			local name = vim.fn.bufname(buf)
			if name:match("fugitive") then
				return "fugitive"
			else
				return vim.fn.fnamemodify(name, ":t")
			end
		end,
	},
}
