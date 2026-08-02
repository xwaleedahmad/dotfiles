local gs = require("gitsigns")
local map = vim.keymap.set

------------------------------------------------------------------
-- Keymaps
------------------------------------------------------------------

-- Navigate between hunks
map("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
map("n", "[h", gs.prev_hunk, { desc = "Previous Hunk" })

-- Hunk actions
map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })

-- Buffer actions
map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })

-- Git blame
map("n", "<leader>gb", gs.blame_line, { desc = "Git Blame" })

--------------------------------------------------
-- Snacks
--------------------------------------------------

map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "lazygit" })

map("n", "<leader>gob", function()
	Snacks.gitbrowse()
end, { desc = "Open repo in browser" })

map("n", "<leader>gf", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })

map("n", "<leader>go", function()
	Snacks.picker.git_diff({ base = "origin", group = true })
end, { desc = "Git Diff (origin)" })

map("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, { desc = "Git Diff (hunks)" })

map("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git Status" })

map("n", "<leader>gx", function()
	Snacks.picker.git_stash()
end, { desc = "Git Stash" })

map("n", "<leader>gi", function()
	Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })

map("n", "<leader>gI", function()
	Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })

map("n", "<leader>gp", function()
	Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })

map("n", "<leader>gP", function()
	Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })
