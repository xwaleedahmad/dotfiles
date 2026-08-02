vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			validate = true,
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			lint = {
				cssConflict = "ignore",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
		},
	},
})
