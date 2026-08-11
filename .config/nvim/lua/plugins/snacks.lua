local map = vim.keymap.set

require("snacks").setup({
	dashboard = {
		enabled = true,
		preset = {
			header = table.concat({
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
			}, "\n"),
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
	explorer = { enabled = true },
	picker = {
		enabled = true,
		sources = {
			files = {
				hidden = true,
				ignored = true,
				exclude = { ".git", "node_modules", "vendor", ".next" },
			},
		},
	},
	indent = { enabled = true },
	scroll = { enabled = false },
	terminal = { enabled = true },
	notifier = { enabled = true },
	git = { enabled = true },
	gh = { enabled = true },
	lazygit = { enabled = true },
	gitbrowse = { enabled = true },
})

-- helper functions
local get_root = function()
	return vim.fn.getcwd()
end

local function get_buffer_dir()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		return get_root()
	end
	return vim.fs.dirname(file)
end

--------------------------------------------------
-- File Explorer & Picker
--------------------------------------------------

map("n", "<leader>e", function()
	Snacks.picker.explorer({ cwd = get_root() })
end, { desc = "Explorer (get_root)" })

map("n", "<leader>E", function()
	Snacks.picker.explorer({ cwd = get_buffer_dir() })
end, { desc = "Explorer (cwd)" })

map("n", "<leader><space>", function()
	Snacks.picker.files()
end, { desc = "Find Files" })

map("n", "<leader>ff", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })

map("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<leader>/", function()
	Snacks.picker.grep({ cwd = get_root() })
end, { desc = "Grep" })

map("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })

map("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })

map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent Files" })

map("n", "<leader>fc", function()
	Snacks.picker.files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = "Find Config Files" })

--------------------------------------------------
-- Buffer Management
--------------------------------------------------

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>br", function()
	local bufs = vim.api.nvim_list_bufs()
	local current = vim.api.nvim_get_current_buf()
	local found_current = false
	for _, buf in ipairs(bufs) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			if found_current then
				Snacks.bufdelete({ buf = buf })
			end
			if buf == current then
				found_current = true
			end
		end
	end
end, { desc = "Delete Buffers to the Right" })

map("n", "<leader>bl", function()
	local bufs = vim.api.nvim_list_bufs()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(bufs) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			if buf == current then
				break
			end
			Snacks.bufdelete({ buf = buf })
		end
	end
end, { desc = "Delete Buffers to the Left" })

--------------------------------------------------
-- General
--------------------------------------------------

map({ "n", "t" }, "<C-/>", function()
	Snacks.terminal.toggle(nil, {
		cwd = get_root(),
		win = { style = "float" },
	})
end, { desc = "Toggle Terminal" })

map("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })
