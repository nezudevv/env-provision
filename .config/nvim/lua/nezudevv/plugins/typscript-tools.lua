return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		settings = {
			tsserver = {
				logVerbosity = "verbose",
			},
		},
	},
	ft = {
		"typescript",
		-- "typescriptreact", -- TypeScript
		"javascript",
		-- "javascriptreact", -- JavaScript
		-- "vue", -- Disabled: Let ts_ls handle Vue with Volar
		"html", -- Vue & AngularJS
	},
	config = function()
		require("typescript-tools").setup({
			-- This is where you pass tsserver settings, including inlay hints
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayVariableTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				-- You can also set auto_inlay_hints to true if you want them enabled by default
				auto_inlay_hints = true,
			},
			-- Other typescript-tools options can go here, e.g.
			-- enable_rename_file_and_update_imports = true,
			-- organize_imports_on_save = true,
		})
	end,
}
