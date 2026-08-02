local map = vim.keymap.set

-- Define signs for each severity
local signs = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.HINT] = "󰠠 ",
	[vim.diagnostic.severity.INFO] = " ",
}

-- diagnostic config function
vim.diagnostic.config({
	signs = { text = signs },
	update_in_insert = false, -- diagnostics shouldn't update while typing
	severity_sort = true, -- sort based on how severe the warning is
	float = { border = "rounded", source = "if_many", style = "minimal", focusable = false },
	underline = true,
	-- underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

-----------------------------------------------------------------
-- Keymaps
-----------------------------------------------------------------

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>cp", vim.diagnostic.setqflist, { desc = "Project Diagnostics" })
