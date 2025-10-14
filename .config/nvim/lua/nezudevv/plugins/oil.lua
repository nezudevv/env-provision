return {
	"stevearc/oil.nvim",
	cmd = { "Oil" },
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
			-- Configuration for the floating window in oil.open_float
			float = {
				-- Padding around the floating window
				padding = 10,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				override = function(conf)
					return conf
				end,
			},
			keymaps = {
				["<ESC><ESC>"] = "actions.close",
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
