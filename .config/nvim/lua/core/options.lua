-----------------------------------------------------------------
-- General Settings
-----------------------------------------------------------------

vim.g.mapleader = " " -- Primary shortcut key (Leader key)
vim.g.maplocalleader = " " -- Secondary shortcut key (Local leader)
vim.opt.autowrite = true -- Save files automatically on buffer switch or task run
vim.opt.confirm = true -- Prompt to save changes before exiting modified buffers
vim.opt.undofile = true -- Keep undo history after closing a file
vim.opt.undolevels = 10000 -- Maximum number of changes that can be undone
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.errorbells = false -- Disable sound effects on errors
vim.opt.backspace = "indent,eol,start" -- Allow backspacing over indents, linebreaks, and inserts
vim.opt.autochdir = false -- Disable changing current directory automatically
vim.opt.encoding = "UTF-8" -- Use UTF-8 encoding for files
vim.opt.timeoutlen = 300 -- Time in ms to wait for a mapped sequence to complete
vim.opt.updatetime = 200 -- Time in ms to trigger CursorHold and save swap file
vim.opt.autoread = true -- auto reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto save
vim.opt.iskeyword:append("-") -- include - in words

-----------------------------------------------------------------
-- Visual / UI Settings
-----------------------------------------------------------------

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true -- Highlight the current line
vim.opt.scrolloff = 8 -- Keep 10 lines of context above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns of context left/right of cursor
vim.opt.wrap = true -- Disable line wrapping
vim.opt.cmdheight = 1 -- Hide command line when not in use
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.signcolumn = "yes" -- Always show the sign column to avoid text shift when sign appears
vim.opt.showmatch = false -- Highlight matching brackets briefly
vim.opt.matchtime = 2 -- Tenths of a second to show matching brackets
vim.opt.showmode = false -- Hide the mode indicator (e.g. -- INSERT --)
vim.opt.pumheight = 10 -- Maximum height of the autocomplete popup menu
vim.opt.pumblend = 10 -- Transparency of the autocomplete popup menu
vim.opt.winblend = 0 -- Transparency of floating windows
vim.opt.list = true -- Show invisible characters like tabs/spaces
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
} -- Customize characters for folds, diffs, and borders
vim.opt.smoothscroll = true -- Enable smooth virtual scroll for wrapped lines
vim.opt.linebreak = true -- Wrap long lines at convenient boundary characters
vim.opt.ruler = false -- Hide default ruler at bottom right
vim.opt.laststatus = 3 -- Use a single global statusline instead of per-window
vim.opt.winminwidth = 5 -- Minimum width for inactive windows

-----------------------------------------------------------------
-- Navigation & Search Settings
-----------------------------------------------------------------

vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if pattern contains uppercase
vim.opt.incsearch = true -- Show search matches incrementally while typing
vim.opt.inccommand = "nosplit" -- Live preview of search/replace commands
vim.opt.wildmenu = true -- Enable command-line completion menu
vim.opt.wildmode = "longest:full,full" -- Command-line completion behavior
vim.opt.wildignorecase = true -- Ignore case in command-line completion
vim.opt.jumpoptions = "view" -- Maintain cursor position/view when jumping

-----------------------------------------------------------------
-- Splits & Window Behavior
-----------------------------------------------------------------

vim.opt.splitbelow = true -- Force horizontal splits to open below the current window
vim.opt.splitright = true -- Force vertical splits to open to the right of the current window
vim.opt.splitkeep = "screen" -- Keep text scroll position stable when splitting windows

-----------------------------------------------------------------
-- Coding & Formatting Settings
-----------------------------------------------------------------

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Number of spaces for auto-indenting
vim.opt.tabstop = 2 -- Number of spaces a tab character represents
vim.opt.softtabstop = 2 -- Number of spaces tab key represents while editing
vim.opt.shiftround = true -- Round indent to a multiple of shiftwidth
vim.opt.smartindent = true -- Insert indents automatically on new lines
vim.opt.autoindent = true -- Copy indent from current line on new lines
vim.opt.breakindent = true -- Wrapped lines keep the original indentation
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep for search/grep
vim.opt.grepformat = "%f:%l:%c:%m" -- Format of ripgrep output
vim.opt.completeopt = "menuone,noinsert,noselect" -- Insert-mode autocompletion options
vim.opt.conceallevel = 2 -- Hide markdown/LaTeX markup symbols (Obsidian requirement)
vim.opt.concealcursor = "" -- Control when text is concealed (empty means show on cursor line)
vim.opt.foldlevel = 99 -- Start with all folds open when opening a file
vim.opt.foldmethod = "indent" -- Fold code based on indentation levels
vim.opt.foldtext = "" -- Use default fold text style
vim.opt.formatoptions = "jcroqlnt" -- Auto-wrap comments and continue comment leaders
vim.opt.virtualedit = "block" -- Allow cursor to move past end-of-line in visual block mode
vim.g.markdown_recommended_style = 0 -- Stop overriding indentation settings in Markdown files
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Suppress specific short messages
