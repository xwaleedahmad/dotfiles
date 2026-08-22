local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

---------------------------------------------------------------------------------

require("noice").setup({
	lsp = {
		progress = { enabled = true },
		hover = { enabled = true },
		signature = { enabled = true },
	},

	presets = {
		command_palette = true,
		long_message_to_split = true,
		inc_rename = true,
		bottom_search = false,
	},
})

---------------------------------------------------------------------------------

local camouflage = require("camouflage")
require("camouflage").setup({
	enabled = true,
	auto_enable = true,
	policy = {
		enabled = true,
		default_action = "ignore",
		rules = {
			{
				id = "api-keys",
				action = "mask",
				key = {
					"api[_%-]*key",
					"apiKey",
				},
			},
			{
				id = "secrets",
				action = "mask",
				key = {
					"secret",
					"client[_%-]*secret",
				},
			},
			{
				id = "tokens",
				action = "mask",
				key = {
					"token",
					"auth[_%-]*token",
					"access[_%-]*token",
				},
			},
			{
				id = "passwords",
				action = "mask",
				key = {
					"password",
					"passwd",
					"passphrase",
				},
			},
			{
				id = "private-keys",
				action = "mask",
				key = {
					"private[_%-]*key",
				},
			},
			{
				id = "credentials",
				action = "mask",
				key = {
					"credential",
				},
			},
		},
	},
})

local json_parser = require("camouflage.parsers.json")
camouflage.register_parser({
	name = "jsonc",
	file_patterns = { "*.jsonc" },
	priority = 60,
	parser = json_parser,
	treesitter = {
		lang = "json",
	},
})

---------------------------------------------------------------------------------
