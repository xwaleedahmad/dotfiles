vim.lsp.config("intelephense", {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { ".git", "composer.json" },
	settings = {
		intelephense = {
			telemetry = {
				enabled = false,
			},
			files = {
				maxSize = 5000000,
				associations = { "*.php" },
			},
			environment = {
				includePaths = { "vendor" },
			},
			stubs = {
				"apache",
				"bcmath",
				"ctype",
				"curl",
				"dom",
				"fileinfo",
				"gd",
				"imagick",
				"intl",
				"json",
				"mbstring",
				"pdo",
				"pdo_mysql",
				"redis",
				"simplexml",
				"soap",
				"sqlite3",
				"xml",
				"xmlreader",
				"xmlwriter",
				"xsl",
				"zip",
			},
		},
	},
})
