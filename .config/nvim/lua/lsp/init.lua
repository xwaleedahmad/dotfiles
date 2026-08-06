local capabilities = vim.lsp.protocol.make_client_capabilities()
-- blink cmp
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Global LSP settings
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Enable LSP servers
vim.lsp.enable({
	"lua_ls",
	"bashls",
	"yamlls",
	"jsonls",
	"marksman",
	"docker_language_server",
	"html",
	"cssls",
	"tailwindcss",
	"vtsls",
	"intelephense",
	"prismals",
	"laravel_ls",
	"copilot",
})

-- LSP specific settings
require("lsp.lua_ls")
require("lsp.bashls")
require("lsp.cssls")
require("lsp.tailwindcss")
require("lsp.vtsls")
require("lsp.intelephense")

-----------------------------------------------------------------
-- Keymaps
-----------------------------------------------------------------

local map = vim.keymap.set

-- Navigation
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })

-- Documentation
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- Actions
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })

-- toggle for inlay hints
map("n", "<leader>uh", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

	vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
	vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"), vim.log.levels.INFO)
end, {
	desc = "Toggle Inlay Hints",
})
