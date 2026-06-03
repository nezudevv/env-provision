local log_file = vim.fn.expand("~/.cache/nvim/git-worktree.log") -- Log file path

local function log_message(msg)
	local file = io.open(log_file, "a")
	if file then
		file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. msg .. "\n")
		file:close()
	end
end
return {
	"ThePrimeagen/git-worktree.nvim",
	config = function()
		local Worktree = require("git-worktree")
		-- Add hooks
		Worktree.on_tree_change(function(op, metadata)
			if op == Worktree.Operations.Create then
				log_message("Creating new worktree...")

				-- Add a delay of 2 seconds (2000 milliseconds)
				vim.defer_fn(function()
					vim.notify("Setting up environment...", vim.log.levels.INFO)

					-- Mapping for shared .env files
					local env_mappings = {
						["es-sync"] = "~/shared-envs/es-sync.env",
						["event-broker"] = "~/shared-envs/event-broker.env",
						["event-worker"] = "~/shared-envs/event-worker.env",
						nucleus = "~/shared-envs/nucleus.env",
						["rates-service"] = "~/shared-envs/rates-service.env",
						root = "~/shared-envs/root.env",
						["vendor-routing"] = "~/shared-envs/vendor-routing.env",
						web = "~/shared-envs/web.env",
						webvue = "~/shared-envs/webvue.env",
					}

					for app, shared_env in pairs(env_mappings) do
						shared_env = vim.fn.expand(shared_env) -- Expand tilde (~)

						-- Correct target path for symlink inside services/{app}
						local target_path = app == "nucleus" and "services/nucleus/nestjs/.env"
							or app == "root" and ".env"
							or string.format("services/%s/.env", app)

						local target_dir = vim.fn.fnamemodify(target_path, ":h") -- Extract target directory
						local dir_exists = vim.fn.isdirectory(target_dir) == 1

						if dir_exists then
							local symlink_command = string.format("ln -sf %s %s", shared_env, target_path)
							os.execute(symlink_command)
						end
					end

					vim.notify("Symlinks created. Starting services...", vim.log.levels.INFO)

					-- Kill any existing tmux session starting with 'fw-'
					os.execute(
						"tmux list-sessions -F \"#{session_name}\" | grep '^fw-' | xargs -I {} tmux kill-session -t {}"
					)

					-- Execute the tmux script
					os.execute("nohup bash ~/.config/scripts/startdev_tmux.sh > ~/.cache/nvim/tmux_debug.log 2>&1 &")

					local worktree_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					local tmux_session = "fw-" .. worktree_name
					vim.notify(
						"Tmux session started.\n\nTo attach, run:\n```sh\ntmux attach -t " .. tmux_session .. "\n```",
						vim.log.levels.INFO
					)
				end, 2000) -- Delay of 2000 milliseconds (2 seconds)
			end

			if op == Worktree.Operations.Switch then
				vim.notify("Switching worktree...", vim.log.levels.INFO)
				-- Kill any existing tmux session starting with 'fw-'
				os.execute(
					"tmux list-sessions -F \"#{session_name}\" | grep '^fw-' | xargs -I {} tmux kill-session -t {}"
				)

				-- Execute the tmux script
				os.execute("nohup bash ~/.config/scripts/startdev_tmux.sh > ~/.cache/nvim/tmux_debug.log 2>&1 &")

				local worktree_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				local tmux_session = "fw-" .. worktree_name
				vim.notify(
					"Tmux session started.\n\nTo attach, run:\n```sh\ntmux attach -t " .. tmux_session .. "\n```",
					vim.log.levels.INFO
				)
			end

		end)
	end,
}
