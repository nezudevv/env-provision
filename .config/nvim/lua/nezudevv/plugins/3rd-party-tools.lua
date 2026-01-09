return {
	-- {
	-- 	"letieu/jira.nvim",
	-- 	opts = {
	-- 		jira = {
	-- 		},
	-- 		-- Saved JQL queries for the JQL tab
	-- 		-- Use %s as a placeholder for the project key
	-- 		queries = {
	-- 			["Current sprint"] = "sprint IN openSprints() AND Team[Team] = df6b9971-bacc-4739-a927-60532ec60ee1 ORDER BY Rank ASC",
	-- 			["Next sprint"] = "project = '%s' AND sprint in futureSprints() AND Team[Team] = df6b9971-bacc-4739-a927-60532ec60ee1 ORDER BY Rank ASC",
	-- 			["Backlog"] = "project = '%s' AND (issuetype IN standardIssueTypes() OR issuetype = Sub-task) AND (sprint IS EMPTY OR sprint NOT IN openSprints()) AND statusCategory != Done AND Team[Team] = df6b9971-bacc-4739-a927-60532ec60ee1 ORDER BY Rank ASC",
	-- 			["My Tasks"] = "assignee = currentUser() AND statusCategory != Done AND Team[Team] = df6b9971-bacc-4739-a927-60532ec60ee1 ORDER BY updated DESC",
	-- 		},
	-- 	},
	-- },
}
