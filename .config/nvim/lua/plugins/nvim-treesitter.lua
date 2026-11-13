local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"bash",
	"diff",
	"zsh",
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
	callback = function(event)
		local buf = event.buf
		local ok = pcall(vim.treesitter.start, buf)

		if not ok then
			return
		end

		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		for _, win in ipairs(vim.fn.win_findbuf(buf)) do
			vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[win].foldmethod = "expr"
		end
	end,
})
