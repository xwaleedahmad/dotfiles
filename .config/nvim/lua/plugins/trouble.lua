require("trouble").setup()

--------------------------------------------------
-- Keymaps
--------------------------------------------------

local map = vim.keymap.set

-- Diagnostics (project)
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", {
	desc = "Diagnostics",
})

-- Diagnostics (current buffer)
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", {
	desc = "Buffer Diagnostics",
})

-- LSP (definitions, references, implementations, etc.)
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", {
	desc = "LSP",
})

-- Symbols in current file
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", {
	desc = "Symbols",
})

-- Quickfix list
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", {
	desc = "Quickfix",
})

-- Location list
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", {
	desc = "Location List",
})
