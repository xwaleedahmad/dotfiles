vim.lsp.config("vtsls", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		"pnpm-workspace.yaml",
		"package-lock.json",
		"yarn.lock",
		"pnpm-lock.yaml",
		"bun.lockb",
		"bun.lock",
		".git",
	},
	single_file_support = true,
	init_options = {
		preferences = {
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
		},
	},
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayVariableTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
			},
		},
		javascript = {
			validate = {
				enable = true,
			},
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayVariableTypeHints = true,
			},
		},
	},
})
