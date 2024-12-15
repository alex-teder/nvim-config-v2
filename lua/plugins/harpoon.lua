return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local conf = require("telescope.config").values
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local themes = require("telescope.themes")
		local telescope_state = require("telescope.actions.state")
		local Path = require("plenary.path")

		harpoon:setup({})

		local function normalize_path(buf_name, root)
			return Path:new(buf_name):make_relative(root)
		end

		local make_finder = function()
			local harpoon_files = harpoon:list()

			local paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(paths, item.value)
			end

			return finders.new_table({
				results = paths,
			})
		end

		local function toggle_telescope()
			pickers
				.new(
					themes.get_ivy({
						initial_mode = "normal",
					}),
					{
						prompt_title = "Harpoon 󱡁 ",
						finder = make_finder(),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
						attach_mappings = function(prompt_buffer_number, map)
							map("n", "dd", function()
								local selected_entry = telescope_state.get_selected_entry()
								local current_picker = telescope_state.get_current_picker(prompt_buffer_number)
								table.remove(harpoon:list().items, selected_entry.index) -- hack
								current_picker:refresh(make_finder())
							end)
							return true
						end,
					}
				)
				:find()
		end

		vim.keymap.set("n", "<C-e>", toggle_telescope, { noremap = true })

		vim.keymap.set("n", "<leader>a", function()
			local relative_file =
				normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.loop.cwd())
			local item = harpoon:list():get_by_value(relative_file)

			if item then
				vim.notify("File already in Harpoon list.")
			else
				harpoon:list():add()
				vim.notify("File added.")
			end
		end, { noremap = true })
	end,
}