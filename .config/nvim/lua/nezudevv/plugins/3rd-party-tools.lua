return {
	"letieu/jira.nvim",
	opts = {
		jira = {
			base = "", -- Base URL of your Jira instance
			email = "", -- Your Jira email (Optional for PAT)
			token = "", -- Your Jira API token or PAT
			type = "basic", -- Authentication type: "basic" (default) or "pat"
			limit = 200, -- Global limit of tasks per view (default: 200)
		},
	},
}
