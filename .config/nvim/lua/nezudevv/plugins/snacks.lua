return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			gitbrowse = { enabled = true },
			picker = {},
		},
		keys = {
			-- Top Level - picker
			{ "<leader><leader>", function() Snacks.picker.buffers() end, desc = "[ ] Find existing buffers" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
			{ "<leader>ss", function() Snacks.picker.pickers() end, desc = "[S]earch [S]elect Picker" }, -- Equivalent to builtin
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
			{ "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
			{ "<leader>s.", function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },

			-- gitbrowse
			{ "<leader>go", function() Snacks.gitbrowse() end, desc = "[G]it [O]pen in Browser", mode = { "n", "v" }},

			-- Advanced / Custom Mappings
			{ "<leader>/", function() Snacks.picker.lines() end, desc = "[/] Fuzzily search in current buffer" },
			{ "<leader>s/", function() Snacks.picker.grep({ buffers = true }) end, desc = "[S]earch [/] in Open Files" },
			{ "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },
		},
	},
	-- {
	-- 	"folke/flash.nvim",
	-- 	event = "VeryLazy",
	-- 	---@type Flash.Config
	-- 	opts = {},
	-- 	keys = {
	-- 		{ "/", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	-- 		{ "?", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	-- 		-- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	-- 		-- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	-- 		-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	-- 	},
	-- }
}
