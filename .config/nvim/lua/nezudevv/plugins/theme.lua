return {
	-- "AlexvZyl/nordic.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("nordic").load({ transparent = { bg = true } })
	-- end,
	---------
	-- "shaunsingh/nord.nvim",
	-- config = function() --Lua:
	-- 	vim.cmd([[colorscheme nord]])
	-- end,

	-- themes
	-- "neanias/everforest-nvim",
	-- version = false,
	-- lazy = false,
	-- priority = 1000, -- make sure to load this before all the other start plugins
	-- -- Optional; default configuration will be used if setup isn't called.
	-- config = function()
	-- 	require("everforest").setup({
	-- 		disable_italic_comments = true,
	-- 		background = "hard",
	-- 		on_highlights = function(hl, palette)
	-- 			-- Remove bold from all highlight groups
	-- 			for group, attrs in pairs(hl) do
	-- 				if attrs.bold then
	-- 					attrs.bold = false
	-- 				end
	-- 			end
	-- 		end,
	-- 	})
	-- end,
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	priority = 1000, -- load before other plugins
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.g.gruvbox_material_foreground = "material"
	-- 		vim.g.gruvbox_material_enable_italic = 1
	-- 		vim.g.gruvbox_material_disable_italic_comment = 0
	-- 		vim.g.gruvbox_material_better_performance = 1
	--
	-- 		vim.o.background = "dark"
	-- 		vim.cmd("colorscheme gruvbox-material")
	-- 	end,
	-- },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = false },
				functionStyle = { bold = false, italic = false },
				keywordStyle = { bold = false, italic = false },
				statementStyle = { bold = false, italic = false },
				typeStyle = { bold = false, italic = false },
				transparent = false,
				dimInactive = false,
				terminalColors = true,
				theme = "dragon",
				background = {
					dark = "dragon",
					light = "lotus",
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						-- Main Neovim UI (Gutter & Floats)
						-- NormalFloat = { bg = "none" },
						-- FloatBorder = { bg = "none" },
						-- FloatTitle = { bg = "none" },
						-- SignColumn = { bg = "none" },
						-- LineNr = { bg = "none" },
						-- WinSeparator = { bg = "none" },

						-- Snacks.nvim Specific Transparency
						-- SnacksBackdrop = { bg = "none" }, -- The dimming effect behind pickers
						-- SnacksNormal = { bg = "none" }, -- Picker background
						-- SnacksBorder = { bg = "none" }, -- Picker border
						-- SnacksInputNormal = { bg = "none" }, -- Input window background
						-- SnacksInputBorder = { bg = "none" }, -- Input window border

						-- Snacks Notifier (for notifications)
						-- SnacksNotifierNormal = { bg = "none" },
						-- SnacksNotifierBorder = { bg = "none" },

						-- Treesitter Context (The sticky header at the top)
						-- TreesitterContext = { bg = "none" },
						-- TreesitterContextLineNumber = { bg = "none" },

						-- Clear all Mini.Statusline sections
						-- MiniStatuslineModeNormal = { bg = "none" },
						-- MiniStatuslineModeInsert = { bg = "none" },
						-- MiniStatuslineModeVisual = { bg = "none" },
						-- MiniStatuslineModeReplace = { bg = "none" },
						-- MiniStatuslineModeCommand = { bg = "none" },
						
						-- MiniStatuslineDevicons = { bg = "none" },
						-- MiniStatuslineFilename = { bg = "none" },
						-- MiniStatuslineFileinfo = { bg = "none" },
						-- MiniStatuslineInactive = { bg = "none" },

						-- GitSigns Transparency
						-- This removes the background from the icons in the gutter
						-- GitSignsAdd = { bg = "none" },
						-- GitSignsChange = { bg = "none" },
						-- GitSignsDelete = { bg = "none" },

						-- CursorLine = { bg = "none", underline = true, sp = colors.palette.dragonBlue },
						-- CursorLineNr = { fg = colors.palette.carpYellow, bg = "none", bold = true },

						-- Keep your keyword overrides from before
						-- Keyword = { fg = colors.palette.fujiWhite, italic = true },
						-- ["@keyword"] = { link = "Keyword" },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end,
		cache = true,
	},
	-- {
	-- 	"dgox16/oldworld.nvim",
	-- 	config = function()
	-- 		require("oldworld").setup({
	-- 			styles = {
	-- 				booleans = { italic = false },
	-- 				comments = { italic = true }, -- style for comments
	-- 				keywords = { italic = false }, -- style for keywords
	-- 				identifiers = { italic = false }, -- style for identifiers
	-- 				functions = { italic = false }, -- style for functions
	-- 				variables = { italic = false }, -- style for variables
	-- 			},
	-- 		})
	-- 	end,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("oldworld")
	-- 	end,
	-- },
}
-- {
-- 	"nyoom-engineering/oxocarbon.nvim",
-- 	init = function()
-- 		-- theme
-- 		vim.opt.background = "dark" -- set this to dark or light
-- 		vim.cmd("colorscheme oxocarbon")
-- 		-- -- transparent
-- 		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 		-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 	end,
-- 	-- Add in any other configuration;
-- 	--
-- 	--   event = foo,
-- 	--   config = bar
-- 	--   end,
-- },
-- { -- You can easily change to a different colorscheme.
-- 	-- Change the name of the colorscheme plugin below, and then
-- 	-- change the command in the config to whatever the name of that colorscheme is.
-- 	--
-- 	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- 	"sainnhe/sonokai",
-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
-- 	init = function()
-- 		-- Load the colorscheme here.
-- 		-- Like many other themes, this one has different styles, and you could load
-- 		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
-- 		vim.cmd.colorscheme("sonokai")
--
-- 		-- You can configure highlights by doing something like:
-- 		vim.cmd.hi("Comment gui=none")
-- 	end,
-- },
