vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "Snacks" },
			},

			completion = {
				callSnippet = "Replace",
			},

			workspace = {
				checkThirdParty = false,
			},
		},
	},
})
