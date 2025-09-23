return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = { enabled = false },
				mccabe = { enabled = false },
				pyflakes = { enabled = false },
				pylint = { enabled = false },
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				mypy = { 
					enabled = true,
					live_mode = true,
					strict = false,
				},
				ruff = {
					enabled = true,
					lineLength = 120,
				},
			},
		},
	},
}