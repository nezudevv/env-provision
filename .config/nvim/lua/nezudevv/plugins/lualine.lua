return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		--
		-- Set bg = "none" for everything in the theme
		-- for _, section in pairs(kanagawa) do
		-- 	for _, hl in pairs(section) do
		-- 		hl.bg = "none"
		-- 	end
		-- end

		require("lualine").setup({
			-- options = {
			-- 	theme = nil -- should auto detect colorscheme,
			-- },
			sections = {
				lualine_a = {},
				lualine_b = { "mode" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = { "buffers" },
				lualine_z = { "tabs" },
			},
			winbar = {
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_y = { "location" },
			},
			inactive_winbar = {
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_y = { "location" },
			},
		})
	end,
}
