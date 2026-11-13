local lint = require("lint")
local tooling = require("plugins.formatting")
local js_filetypes = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
}

lint.linters_by_ft = {
	javascript = { "eslint", "biomejs" },
	javascriptreact = { "eslint", "biomejs" },
	typescript = { "eslint", "biomejs" },
	typescriptreact = { "eslint", "biomejs" },

	graphql = { "biomejs" },
	json = { "biomejs" },
	jsonc = { "biomejs" },
	css = { "biomejs" },
	scss = { "biomejs" },

	sh = { "shellcheck" },
	bash = { "shellcheck" },
	markdown = { "markdownlint-cli2" },
}

local function run_project_linter(bufnr)
	bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
	local tools = tooling.get_js_tools(bufnr)
	local js_filetype = js_filetypes[vim.bo[bufnr].filetype]

	vim.api.nvim_buf_call(bufnr, function()
		lint.try_lint(nil, {
			cwd = tools.root or vim.fn.getcwd(),
			filter = function(linter)
				if linter.name == "biomejs" then
					return tools.linter == "biomejs"
				elseif linter.name == "eslint" then
					return js_filetype and tools.linter == "eslint"
				end
				return true
			end,
		})
	end)
end

local group = vim.api.nvim_create_augroup("Lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = group,
	callback = function(args)
		run_project_linter(args.buf)
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	run_project_linter(0)
end, { desc = "Run Linter" })
