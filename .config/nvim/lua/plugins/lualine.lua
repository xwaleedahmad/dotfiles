local ignored = {
	copilot = true,
	tailwindcss = true,
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

local function js_tooling()
	local tools = require("plugins.formatting").get_js_tools(0)
	if tools.formatter == "biome" then
		return "biome"
	elseif tools.formatter == "prettier" then
		return "prettier"
	end
	return ""
end

local function tooling_status()
	local items = {}
	local filetype = vim.bo.filetype
	local web_filetype = filetype == "javascript"
		or filetype == "javascriptreact"
		or filetype == "typescript"
		or filetype == "typescriptreact"
		or filetype == "json"
		or filetype == "jsonc"
		or filetype == "css"
		or filetype == "scss"
		or filetype == "graphql"
		or filetype == "html"
		or filetype == "less"

	local formatter = web_filetype and js_tooling() or ""
	if formatter ~= "" then
		table.insert(items, formatter)
	end

	local servers = vim.api.nvim_win_get_width(0) >= 120 and lsp_name() or ""
	if servers ~= "" then
		table.insert(items, servers)
		return "󰒋 " .. table.concat(items, ", ")
	end

	return table.concat(items, ", ")
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
			tooling_status,
		},
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	lualine_z = { "progress" },
})
