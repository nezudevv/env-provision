return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	opts = {
		ui = {
			border = "rounded",
		},
		lightbulb = {
			enable = false, -- Can be noisy, disable if you prefer
		},
		symbol_in_winbar = {
			enable = false, -- Breadcrumbs in winbar, disable if not wanted
		},
	},
}
