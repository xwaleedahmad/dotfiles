vim.lsp.config("cssls", {
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true },
	single_file_support = true,
	root_markers = { "package.json", ".git" },
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
			validate = true,
		},
		scss = {
			lint = {
				unknownAtRules = "ignore",
			},
			validate = true,
		},
		less = {
			lint = {
				unknownAtRules = "ignore",
			},
			validate = true,
		},
	},
})
