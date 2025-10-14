-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- g
-- moved leader set to lazy_init file to ensure it is set before plugins are loaded

-- keymap
---- normal
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "U", "<C-r>") --  Remap Undo
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Diagnostic keymaps
vim.keymap.set("n", ";", ":") -- remap ; to : (for better repeat)
vim.keymap.set("n", ":", ";") -- remap : to ; (for better repeat)
vim.keymap.set("n", "<leader>x", ":bd<CR>", { silent = true }) -- Close the current buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true }) -- Move to the next buffer
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true }) -- Move to the previous buffer
vim.keymap.set("n", "-", "<CMD>:Oil --float<CR>", { desc = "Open current directory" }) -- open oil
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>') -- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>') -- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>') -- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>') -- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<C-c>", "ggVG\"+y", { noremap = true, silent = true }) -- Copy the entire buffer to the system clipboard
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>gww", function() -- Show Git Worktrees
	require("telescope").extensions.git_worktree.git_worktrees()
end, { desc = "Show Git Worktrees" })
vim.keymap.set("n", "<leader>gwn", function() -- Create new worktree
	-- Prompt for the worktree name (used for both path and branch)
	vim.ui.input({ prompt = "Enter worktree name (used for path and branch): " }, function(name)
		if not name or name == "" then
			print("Worktree creation canceled")
			return
		end
		-- Create the worktree using the same value for both path and branch
		require("git-worktree").create_worktree(name, name)
		print("Worktree created at: " .. name .. " with branch: " .. name)
	end)
end, { desc = "New Git Worktree" })
vim.keymap.set("n", "<leader>rl", function()
    local is_relative = vim.wo.relativenumber
    vim.wo.relativenumber = not is_relative
end, { desc = "Toggle relative line numbers" })

---- visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move line up


-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

