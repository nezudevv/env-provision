return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",

	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },

		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		--  This function gets run when an LSP attaches to a particular buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", function()
					Snacks.picker.lsp_references()
				end, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				map("gI", function()
					Snacks.picker.lsp_implementations()
				end, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				map("gt", function()
					Snacks.picker.lsp_type_definitions()
				end, "[G]oto Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				-- Note: Snacks uses 'lsp_symbols' for document symbols
				map("gs", function()
					Snacks.picker.lsp_symbols()
				end, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				map("<leader>ws", function()
					Snacks.picker.lsp_workspace_symbols()
				end, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- Goto Declaration
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Hover documentation
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- Toggle inlay hints
				map("<leader>rk", function()
					vim.lsp.inlay_hint.enable(
						not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
						{ bufnr = event.buf }
					)
				end, "Toggle [r]Inlay [k]Hints")

				-- Highlight references of the word under your cursor
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Enable inlay hints for this buffer
				vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers
		local servers = {
			-- Note: ts_ls and volar are configured manually below using vim.lsp.config()
			-- Don't add vue_ls here - it's the same as volar and causes duplicates
			vtsls = { enabled = false }, -- Disable vtsls, we're using ts_ls
			tsgo = {},
			ts_ls = { enabled = false },
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" }, -- Recognize 'vim' as a global
							-- disable = { 'missing-fields' }, -- Optionally disable noisy warnings
						},
					},
				},
			},
		}

		-- Ensure the servers and tools above are installed
		require("mason").setup()

		-- You can add other tools here that you want Mason to install
		-- Filter out disabled servers
		local ensure_installed = {}
		for server_name, server_opts in pairs(servers or {}) do
			-- Only include servers that are not explicitly disabled
			if type(server_opts) ~= "table" or server_opts.enabled ~= false then
				table.insert(ensure_installed, server_name)
			end
		end
		vim.list_extend(ensure_installed, {
			"stylua",
			"typescript-language-server", -- ts_ls: required by vue_ls for Vue SFCs
			"vue-language-server",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Setup ts_ls and volar manually (must be done AFTER mason-lspconfig to override defaults)
		local lspconfig = require("lspconfig")

		-- Setup other servers via mason-lspconfig (excluding manually configured servers)
		require("mason-lspconfig").setup({
			automatic_installation = false, -- Don't auto-install LSP servers
			handlers = {
				function(server_name)
					-- Skip servers we configured manually with vim.lsp.config() or disabled
					-- Note: vue_ls and volar are the same server, we handle it manually as "volar"
					if server_name == "ts_ls" or server_name == "vue_ls" or server_name == "vtsls" or server_name == "tsgo" then
						return
					end
					local server = servers[server_name] or {}
					-- Check if server is explicitly disabled
					if server.enabled == false then
						return
					end
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					lspconfig[server_name].setup(server)
				end,
			},
		})

		-- ts_ls restricted to vue only — vue_ls requires it as a hybrid mode dependency.
		-- tsgo handles plain TS/JS files; ts_ls handles the TS layer inside Vue SFCs.
		vim.lsp.config("ts_ls", {
			cmd = { "typescript-language-server", "--stdio" },
			capabilities = capabilities,
			filetypes = { "vue" },
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.fn.trim(vim.fn.system("npm root -g")) .. "/@vue/language-server",
						languages = { "vue" },
					},
				},
			},
		})
		vim.lsp.enable("ts_ls")
		-- Define the tsgo configuration
		vim.lsp.config("tsgo", {
			cmd = { "tsgo", "--lsp", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			capabilities = capabilities,
		})

		-- Enable it
		vim.lsp.enable("tsgo")

		-- Setup vue_ls (formerly volar) AFTER ts_ls
		vim.lsp.config("vue_ls", {
			cmd = { "vue-language-server", "--stdio" },
			capabilities = capabilities,
			filetypes = { "vue" },
			root_markers = { "package.json" },
		})

		-- Enable both servers
		-- vim.lsp.enable("ts_ls")
		vim.lsp.enable("vue_ls")
	end,
}
