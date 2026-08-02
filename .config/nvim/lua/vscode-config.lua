local map = vim.keymap.set
local vscode = require("vscode")

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
vim.pack.add({
	"https://github.com/nvim-mini/mini.ai",
	"https://github.com/nvim-mini/mini.surround",
})

require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()

--------------------------------------------------------------------------------
-- Keybinds
--------------------------------------------------------------------------------

-- quick access to files and editors
map("n", "<leader><leader>", function()
	vscode.action("workbench.action.quickOpen")
end)
map("n", "<leader>,", function()
	vscode.action("workbench.action.showAllEditors")
end)
map("n", "<leader>e", function()
	vscode.action("workbench.action.toggleSidebarVisibility")
end)
map("n", "<leader>/", function()
	vscode.action("workbench.action.findInFiles")
end)

-- close active buffer
map("n", "<leader>bd", function()
	vscode.action("workbench.action.closeActiveEditor")
end)

-- splits
map("n", "<leader>sv", function()
	vscode.action("workbench.action.moveEditorToRightGroup")
end)
map("n", "<leader>sh", function()
	vscode.action("workbench.action.moveEditorToBelowGroup")
end)

-- format document
map("n", "<leader>cf", function()
	vscode.action("editor.action.formatDocument")
end)
