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

--------------------------------------------------
-- Keymaps
--------------------------------------------------

vim.keymap.set("n", "<leader>sn", "<cmd>Noice history<CR>", {
	desc = "Notification History",
})
