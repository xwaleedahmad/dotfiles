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

vim.cmd.colorscheme("catppuccin-mocha")

local colors = require("catppuccin.palettes").get_palette("mocha")
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
	fg = colors.lavender,
})
vim.api.nvim_set_hl(0, "SnacksDashboardIcon", {
	fg = colors.lavender,
})
vim.api.nvim_set_hl(0, "SnacksDashboardKey", {
	fg = colors.lavender,
})
vim.api.nvim_set_hl(0, "SnacksDashboardDesc", {
	fg = colors.lavender,
})
vim.api.nvim_set_hl(0, "SnacksDashboardFooter", {
	fg = colors.lavender,
})
