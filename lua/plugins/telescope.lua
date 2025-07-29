return {
	"nvim-telescope/telescope.nvim",
	enabled = true,
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},

		defaults = {
			mappings = {
				i = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview, ["<C-c>"] = false },
				n = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview },
			},
			path_display = { "truncate" },
			buffer_previewer_maker = function(filepath, bufnr, opts)
				local f = vim.fn.expand(filepath)
				if f:match("%.env$") then
					return false
				end

				local stat = vim.loop.fs_stat(f)
				if stat and stat.size > 200 * 1024 then -- 200KB
					return false
				end

				require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
			end,
			selection_caret = "  ",
			prompt_prefix = "󱞩 ",
		},

		pickers = {
			registers = { initial_mode = "normal" },
			git_files = { theme = "ivy", preview = { hide_on_startup = true } },
			live_grep = {
				theme = "ivy",
				disable_coordinates = true,
				additional_args = { "--hidden", "--glob", "!.git/**" },
			},
			git_branches = { theme = "ivy", previewer = false },
			help_tags = { theme = "ivy" },
			lsp_type_definitions = {
				theme = "ivy",
				initial_mode = "normal",
				show_line = false,
			},
			lsp_references = {
				theme = "ivy",
				initial_mode = "normal",
				show_line = false,
			},
			buffers = {
				theme = "ivy",
				show_all_buffers = true,
				sort_lastused = true,
				path_display = { "tail" },
				mappings = {
					n = {
						["dd"] = "delete_buffer",
					},
				},
			},
			colorscheme = {
				selection_caret = "> ",
				enable_preview = true,
			},
		},
	},

	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
		local builtin = require("telescope.builtin")
		local C = require("catppuccin.palettes").get_palette(require("catppuccin").options.flavour)

		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = C.base })

		local default_color = { fg = C.blue }
		local colors = {
			registers = { fg = C.pink },
			git_files = { fg = C.yellow },
			live_grep = { fg = C.green },
			help_tags = { fg = C.teal },
			git_branches = { fg = C.mauve },
		}

		local function handle_open(picker_name)
			return function()
				local color = colors[picker_name]
				vim.api.nvim_set_hl(0, "TelescopeBorder", color or default_color)
				builtin[picker_name]()
			end
		end

		vim.keymap.set("n", "<leader>ff", handle_open("git_files"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fg", handle_open("live_grep"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>w", handle_open("buffers"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gb", handle_open("git_branches"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fh", handle_open("help_tags"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fr", handle_open("lsp_references"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>cb", handle_open("registers"), { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>re", builtin.resume, { noremap = true, silent = true })
	end,
}
