vim.pack.add({
	-- UI Components
	"https://github.com/catppuccin/nvim",
	"https://github.com/neanias/everforest-nvim",
	"https://github.com/RRethy/base16-nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/MunifTanjim/nui.nvim", -- dependency for noice
	"https://github.com/folke/noice.nvim",

	-- Core Utilities
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- dependency for git plugins
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/kdheepak/lazygit.nvim",
	"https://github.com/chentoast/marks.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",
	"https://github.com/3rd/image.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	{ src = "https://github.com/iamcco/markdown-preview.nvim", build = ":call mkdp#util#install()" },

	-- Treesitter & Syntax
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	"https://github.com/folke/ts-comments.nvim",
	"https://github.com/windwp/nvim-ts-autotag",

	-- Coding / Text Objects
	"https://github.com/nvim-mini/mini.ai",
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/echasnovski/mini.pairs",
	"https://github.com/nvim-mini/mini.splitjoin",
	"https://github.com/nvim-mini/mini.hipatterns",

	-- LSP Management
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",

	-- Completion & Snippets
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

-----------------------------------------------------------------------------------------------------------------
-- Plugins Setup
-----------------------------------------------------------------------------------------------------------------

-- Set up theme and icons before everything else
require("plugins.colorscheme")
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

-- Core utilities
require("plugins.snacks")
require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup({ mappings = { toggle = "sj" } })
require("smear_cursor").setup()
require("plugins.git")
require("marks").setup()
require("image").setup({ max_height_window_percentage = 80 })

-- Treesitter, auto tags and comments
require("plugins.nvim-treesitter")
require("ts-comments").setup()
require("nvim-ts-autotag").setup()
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

-- LSP management, code completion, formatting & linting
require("plugins.mason")
require("plugins.blink")
require("plugins.formatting")
require("plugins.linting")

-- UI components
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.noice")
require("plugins.trouble")
