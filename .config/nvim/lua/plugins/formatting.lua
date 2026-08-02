require("conform").setup({

	-- Formatter for each filetype
	formatters_by_ft = {
		lua = { "stylua" },

		json = { "prettier" },
		yaml = { "prettier" },
		dockerfile = { "dockerfmt" },

		html = { "prettier" },
		css = { "prettier" },

		markdown = { "prettier" },

		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },

		php = { "pint" },
		blade = { "blade-formatter" },

		bash = { "shfmt" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
	},

	formatters = {
		shfmt = {
			prepend_args = function(_, ctx)
				if vim.bo[ctx.buf].filetype == "zsh" then
					return { "-ln", "zsh" }
				end

				return { "-ln", "bash" }
			end,
		},
	},

	-- Default formatting options
	default_format_opts = {
		lsp_format = "fallback",
		timeout_ms = 1000,
	},

	-- Format automatically when saving
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},

	notify_on_error = true,
})

-- Keymaps
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		async = true,
	})
end, { desc = "Format Buffer" })
