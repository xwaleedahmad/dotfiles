local map = vim.keymap.set

-----------------------------------------------------------------
-- General
-----------------------------------------------------------------

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

map("n", "<leader>ul", "<cmd>CopilotToggle<cr>", { desc = "Toggle Copilot (global)" })
map("n", "<leader>um", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })

-----------------------------------------------------------------
-- Navigation
-----------------------------------------------------------------

-- move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- move between buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- move lines up & down
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- split windows
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- page scroll behavior
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-----------------------------------------------------------------
-- Coding
-----------------------------------------------------------------

-- better indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Keep copied text when deleting single chars
map({ "n", "x" }, "x", '"_x')
map({ "n", "x" }, "X", '"_X')

-- Keep copied text when changing text
map({ "n", "x" }, "c", '"_c')

-- Visual paste should not overwrite what was yanked
map("x", "p", '"_dP')

-- toggle line wrap
map("n", "<leader>uw", function()
	vim.wo.wrap = not vim.wo.wrap
	vim.wo.linebreak = vim.wo.wrap
end, { desc = "Toggle Line Wrap" })
