return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local conf = require("telescope.config").values

		harpoon:setup({})

		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new(
					require("telescope.themes").get_ivy({
						initial_mode = "normal",
					}),
					{
						prompt_title = "Harpoon 󱡁 ",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					}
				)
				:find()
		end

		vim.keymap.set("n", "<C-e>", function()
			toggle_telescope(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
			print("File added.")
		end)

		vim.keymap.set("n", "<leader>d", function()
			harpoon:list():remove()
			print("File removed.")
		end)
	end,
}
