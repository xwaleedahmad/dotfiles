local M = {}

local config_names = {
	biome = { "biome.json", "biome.jsonc" },
	prettier = {
		".editorconfig",
		".prettierrc",
		".prettierrc.json",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		".prettierrc.ts",
		".prettierrc.mts",
		".prettierrc.cts",
		".prettierrc.yaml",
		".prettierrc.yml",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
		"prettier.config.ts",
		"prettier.config.mts",
		"prettier.config.cts",
	},
	eslint = {
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		"eslint.config.ts",
		"eslint.config.mts",
		"eslint.config.cts",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
	},
}

-- Find project ancestors once. Local node_modules/.bin executables are the
-- signal that a package.json dependency has actually been installed.
local function project_dirs(bufnr)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	if filename == "" then
		return {}, nil
	end

	local dirs, root = {}, nil
	local dir = vim.fs.dirname(filename)
	while dir do
		table.insert(dirs, dir)
		if
			vim.fn.filereadable(vim.fs.joinpath(dir, "package.json")) == 1
			or vim.fn.filereadable(vim.fs.joinpath(dir, "composer.json")) == 1
		then
			root = root or dir
		end
		if vim.uv.fs_stat(vim.fs.joinpath(dir, ".git")) or vim.uv.fs_stat(vim.fs.joinpath(dir, ".hg")) then
			root = root or dir
			break
		end
		local parent = vim.fs.dirname(dir)
		if parent == dir then
			break
		end
		dir = parent
	end
	return dirs, root or dirs[1]
end

local function has_local_binary(dirs, name)
	for _, dir in ipairs(dirs) do
		for _, suffix in ipairs({ name, name .. ".cmd" }) do
			if vim.fn.executable(vim.fs.joinpath(dir, "node_modules", ".bin", suffix)) == 1 then
				return dir
			end
		end
	end
	return nil
end

local function config_depth(dirs, tool)
	for depth, dir in ipairs(dirs) do
		for name in vim.fs.dir(dir) do
			if vim.tbl_contains(config_names[tool], name) then
				return depth
			end
			-- Prettier also supports a `prettier` key in package.json.
			if tool == "prettier" and name == "package.json" then
				local path = vim.fs.joinpath(dir, name)
				local ok, package = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
				if ok and type(package) == "table" and package.prettier ~= nil then
					return depth
				end
			end
		end
	end
	return nil
end

function M.get_js_tools(bufnr)
	bufnr = bufnr or 0
	bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
	local dirs, root = project_dirs(bufnr)
	local biome_root = has_local_binary(dirs, "biome")
	local prettier_root = has_local_binary(dirs, "prettier")
	local eslint_root = has_local_binary(dirs, "eslint")
	local biome_depth = config_depth(dirs, "biome")
	local prettier_depth = config_depth(dirs, "prettier")
	local eslint_depth = config_depth(dirs, "eslint")
	local classic_depth = prettier_depth and eslint_depth and math.min(prettier_depth, eslint_depth)
		or prettier_depth
		or eslint_depth
	local mode

	-- The nearest explicit config wins. Conflicting configs at the same level
	-- are ambiguous, so do not silently run either toolchain.
	if biome_depth and classic_depth then
		if biome_depth < classic_depth then
			mode = "biome"
		elseif classic_depth < biome_depth then
			mode = "classic"
		end
	elseif biome_depth then
		mode = "biome"
	elseif classic_depth then
		mode = "classic"
	elseif biome_root and not prettier_root and not eslint_root then
		mode = "biome"
	elseif (prettier_root or eslint_root) and not biome_root then
		mode = "classic"
	end

	local formatter, linter
	if mode == "biome" and biome_root then
		formatter, linter = "biome", "biomejs"
	elseif mode == "classic" then
		formatter = prettier_root and "prettier" or nil
		linter = eslint_root and eslint_depth and "eslint" or nil
	end

	local tool_root = linter == "biomejs" and biome_root or linter == "eslint" and eslint_root or root
	return { mode = mode, formatter = formatter, linter = linter, root = tool_root }
end

local function project_web_formatter(bufnr)
	local formatter = M.get_js_tools(bufnr).formatter
	return formatter and { formatter } or {}
end

local function project_prettier(bufnr)
	local tools = M.get_js_tools(bufnr)
	return tools.mode == "classic" and tools.formatter == "prettier" and { "prettier" } or {}
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		dockerfile = { "dockerfmt" },
		markdown = { "mdformat" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		zsh = { "shfmt" },

		-- Project tools: local Biome or Prettier, selected from config/dependencies.
		-- To add another tool, add its local binary/config check above and its
		-- Conform name here. Keep project-installed tools out of Mason.
		javascript = project_web_formatter,
		javascriptreact = project_web_formatter,
		typescript = project_web_formatter,
		typescriptreact = project_web_formatter,
		json = project_web_formatter,
		jsonc = project_web_formatter,
		css = project_web_formatter,
		scss = project_web_formatter,
		graphql = project_web_formatter,
		html = project_prettier,
		less = project_prettier,
	},

	formatters = {
		shfmt = {
			prepend_args = function(_, ctx)
				return vim.bo[ctx.buf].filetype == "zsh" and { "-ln", "zsh" } or { "-ln", "bash" }
			end,
		},
	},

	default_format_opts = { lsp_format = "fallback", timeout_ms = 1000 },
	format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
	notify_on_error = true,
	notify_no_formatters = true,
})

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "Format Buffer" })

return M
