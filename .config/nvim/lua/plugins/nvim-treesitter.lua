local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"bash",
	"diff",
	"zsh",
	"kdl",
	"lua",
	"luadoc",
	"vim",
	"vimdoc",
	"markdown",
	"markdown_inline",
	"query",
	"regex",
	"gitignore",
	"dockerfile",
	"yaml",
	"xml",
	"json",
	"jsdoc",
	"toml",
	"python",
	"html",
	"css",
	"javascript",
	"typescript",
	"tsx",
	"prisma",
	"php",
	"blade",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)

		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
