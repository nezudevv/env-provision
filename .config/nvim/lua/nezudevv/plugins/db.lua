return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		require("dbee").install()
	end,
	config = function()
		require("dbee").setup({
			sources = {
				require("dbee.sources").MemorySource:new({
					{
						name = "fw local",
						type = "postgres",
						url = os.getenv("DBEE_PG_URL"),
					},
				}),
				-- require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
			},
		})
	end,
}
