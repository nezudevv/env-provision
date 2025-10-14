-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
-- vim.o sets global options.
-- vim.opt allows setting global, window, or buffer-local options more easily.
-- vim.g is used to set/get global variables in Neovim. These variables are often used by plugins or user scripts.

-- o
vim.o.shiftwidth = 4
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- opt
vim.opt.breakindent = true -- Enable break indent
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.list = true -- display certain whitespace characters in the editor. See `:help 'list'` and `:help 'listchars'`
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- display certain whitespace characters in the editor.:help'list''listchars`
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.scrolloff = 12 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftwidth = 4
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true -- Configure how new splits should be opened
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time Displays which-key popup sooner
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 150 -- Decrease update time

-- g
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false


-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--  vim.schedule() is a function in Neovim that defers the execution of a Lua callback until the next event loop cycle. This is useful when you need to:
-- Run code asynchronously after Neovim processes the current task.
-- Avoid errors when calling functions that must be executed within the main event loop.
-- Ensure safe execution of functions inside async callbacks, autocmds, or APIs that run in different threads.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
