require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},
	completion = {
		menu = {
			auto_show = true,
		},
		documentation = {
			auto_show = true,
		},
		ghost_text = {
			enabled = false,
			show_with_menu = false,
		},
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
	},
	cmdline = {
		enabled = true,
		keymap = { preset = "cmdline" },
		completion = {
			menu = { auto_show = true },
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
		providers = {
			lsp = {
				opts = {
					tailwind_color_icon = "󱓻", -- Better tailwind css icon
				},
			},
		},
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	snippets = {
		preset = "luasnip",
	},
})

-- load vs code snippets (friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()
