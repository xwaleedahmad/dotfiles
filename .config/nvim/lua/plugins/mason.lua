require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	automatic_enable = false,
	ensure_installed = {
		"lua_ls",
		"bashls",
		"yamlls",
		"jsonls",
		"marksman",
		"docker_language_server",
		"html",
		"cssls",
		"tailwindcss",
		"vtsls",
		"prismals",
		"intelephense",
		"laravel_ls",

		"copilot",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		-- Formatters
		"dockerfmt",
		"prettier",
		"stylua",
		"shfmt",
		"pint",
		"blade-formatter",

		-- Linters
		"eslint_d",
		"shellcheck",
		"phpstan",
	},
})

-- import lsp config
require("lsp")

-- keybind
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason" })
