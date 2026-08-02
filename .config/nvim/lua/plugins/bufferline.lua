require("bufferline").setup({
	options = {
		always_show_bufferline = false,
		separator_style = "slope",
		show_buffer_icons = true,
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
			{
				filetype = "snacks_layout_box",
			},
		},
	},
})
