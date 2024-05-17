local function check_project_files_pattern(pattern)
	local project_root = vim.fn.getcwd()
	local handle = vim.loop.fs_scandir(project_root)

	if not handle then
		return false
	end

	local function iterate()
		return vim.loop.fs_scandir_next(handle)
	end

	for name in iterate do
		if name:match(pattern) then
			local full_path = project_root .. "/" .. name
			local stat = vim.loop.fs_stat(full_path)
			if stat and stat.type == "file" then
				return true
			end
		end
	end

	return false
end
-- -- Function to check if a file exists in the project directory
-- local function file_exists(filename)
-- 	local stat = vim.loop.fs_stat(filename)
-- 	return stat and stat.type == "file" or false
-- end
--
-- -- Function to check if any file in a table of possible names exists in the project directory
-- local function check_project_files(filenames)
-- 	local project_root = vim.fn.getcwd()
-- 	for _, filename in ipairs(filenames) do
-- 		local full_path = project_root .. "/" .. filename
-- 		if file_exists(full_path) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

-- lint.linters.eslint_d.args = {
-- 	"--format",
-- 	"json",
-- 	"--stdin",
-- 	"--stdin-filename",
-- 	function()
-- 		return vim.api.nvim_buf_get_name(0)
-- 	end,
-- }

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		if not check_project_files_pattern("eslint") then
			table.insert(lint.linters.eslint_d.args, 1, "--no-warn-ignored")
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
