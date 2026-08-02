local lint = require("lint")

-- Linter for each filetype
lint.linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },

	-- php = { "phpstan" },

	sh = { "shellcheck" },
	bash = { "shellcheck" },
}

-- Run lint automatically
local group = vim.api.nvim_create_augroup("Lint", { clear = true })

vim.api.nvim_create_autocmd({
	"BufEnter",
	"BufWritePost",
	"InsertLeave",
}, {
	group = group,
	callback = function()
		lint.try_lint()
	end,
})

-- Keymap
vim.keymap.set("n", "<leader>ll", function()
	lint.try_lint()
end, { desc = "Run Linter" })
