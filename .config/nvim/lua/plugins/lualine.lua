local ignored = {
	copilot = true,
}

local function lsp_name()
	local names = {}

	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		if not ignored[client.name] then
			table.insert(names, client.name)
		end
	end

	return table.concat(names, ", ")
end

require("lualine").setup({
	options = {
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		-- component_separators = { left = '', right = ''},
		-- section_separators = { left = '', right = ''},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "branch", icon = "", colored = true },
			{
				"diff",
				colored = true,
				symbols = { added = " ", modified = " ", removed = " " },
			},
			{
				"diagnostics",
				colored = true,
				symbols = { error = " ", warn = " ", info = "󰠠 ", hint = " " },
			},
		},
		lualine_c = {
			{ "filetype", icon_only = true, separator = "" },
			{
				"filename",
				path = 1,
				symbols = { modified = "", readonly = "", unnamed = "[No Name]", newfile = "[New]" },
			},
		},
		lualine_x = {
			{
				lsp_name,
				icon = "󰒋",
				cond = function()
					return lsp_name() ~= ""
				end,
			},
		},
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	lualine_z = { "progress" },
})
