vim.api.nvim_create_user_command("AugmentToggleCompletions", function()
	vim.g.augment_disable_completions = not vim.g.augment_disable_completions
	print("Augment completions " .. tostring(not vim.g.augment_disable_completions and "enabled" or "disabled"))
end, {})

return { "augmentcode/augment.vim" }
