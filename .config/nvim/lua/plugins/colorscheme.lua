require("catppuccin").setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	term_colors = true,

	default_integrations = true,

	integrations = {
		blink_cmp = true,
		conform = true,
		gitsigns = true,
		treesitter = true,
		mini = true,
		snacks = true,
		mason = true,
		noice = true,
	},
})
require("everforest").setup({
	background = "hard",
})

vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("everforest")
