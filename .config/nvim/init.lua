require("core.options")

if vim.g.vscode then
	require("vscode-config")
else
	require("core.keymaps")
	require("core.autocmds")
	require("core.diagnostics")
	require("plugins")
end
