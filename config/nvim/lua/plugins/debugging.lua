return {
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mxsdev/nvim-dap-vscode-js",
			-- lazy spec to build "microsoft/vscode-js-debug" from source
			{
				"microsoft/vscode-js-debug",
				version = "1.92.0",
				build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
			})

			-- This function finds the closest jest.config.ts or jest.config.js file related to current file
			-- and run test only for that file
			local function find_closest_jest_config()
				-- Get the full path of the current file in the active buffer
				local file = vim.fn.expand("%:p")

				-- Check if the file is within a 'libs' or 'apps' directory
				if string.find(file, "/libs/") or string.find(file, "/apps/") then
					-- Extract the path up to the project directory (e.g., 'libs/one-lib/')
					local project_dir = string.match(file, "(.-/[^/]+/)src")
					if project_dir then
						-- Return the path to the jest.config.ts or jest.config.js in the project directory
						local jest_config_ts = project_dir .. "jest.config.ts"
						local jest_config_js = project_dir .. "jest.config.js"
						if vim.fn.filereadable(jest_config_ts) == 1 then
							return jest_config_ts
						elseif vim.fn.filereadable(jest_config_js) == 1 then
							return jest_config_js
						end
					end
				end

				-- Fallback to the jest.config.ts or jest.config.js in the root directory
				local root_jest_config_ts = vim.fn.getcwd() .. "/jest.config.ts"
				local root_jest_config_js = vim.fn.getcwd() .. "/jest.config.js"
				if vim.fn.filereadable(root_jest_config_ts) == 1 then
					return root_jest_config_ts
				elseif vim.fn.filereadable(root_jest_config_js) == 1 then
					return root_jest_config_js
				end

				-- If no jest.config is found, return nil
				return nil
			end

			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug Jest Tests",
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
							"--config=" .. find_closest_jest_config(),
							-- Run only tests for the current file, will match either test file directly or if the source file has same name as test file
							"--testPathPattern=" .. vim.fn.expand("%:t:r"),
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome to debug React on port 3000",
						request = "launch",
						url = "http://localhost:8023",
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}/src",
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome to debug React on port 3000",
						request = "launch",
						url = "http://localhost:3000",
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}/src",
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome to debug MMM app",
						request = "launch",
						url = "http://localhost:8020",
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}/src",
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
					-- attach to a node process that has been started with
					-- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
					-- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
					-- TODO: not implemented yet
					-- {
					-- 	-- use nvim-dap-vscode-js's pwa-node debug adapter
					-- 	type = "pwa-node",
					-- 	-- attach to an already running node process with --inspect flag
					-- 	-- default port: 9222
					-- 	request = "attach",
					-- 	-- allows us to pick the process using a picker
					-- 	processId = require("dap.utils").pick_process,
					-- 	-- name of the debug action you have to select for this config
					-- 	name = "Attach debugger to existing `node --inspect` process",
					-- 	-- for compiled languages like TypeScript or Svelte.js
					-- 	sourceMaps = true,
					-- 	-- resolve source maps in nested locations while ignoring node_modules
					-- 	resolveSourceMapLocations = {
					-- 		"${workspaceFolder}/**",
					-- 		"!**/node_modules/**",
					-- 	},
					-- 	-- path to src in vite based projects (and most other projects as well)
					-- 	cwd = "${workspaceFolder}/src",
					-- 	-- we don't want to debug code inside node_modules, so skip it!
					-- 	skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					-- },
					-- {
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	name = "Debug Vitest Tests _TODO",
					-- 	-- trace = true, -- include debugger info
					-- 	runtimeExecutable = "node",
					-- 	runtimeArgs = {
					-- 		"./node_modules/jest/bin/jest.js",
					-- 		"--runInBand",
					-- 	},
					-- 	rootPath = "${workspaceFolder}",
					-- 	cwd = "${workspaceFolder}",
					-- 	console = "integratedTerminal",
					-- 	internalConsoleOptions = "neverOpen",
					-- },
					-- only if language is javascript, offer this debug action
					language == "javascript"
							and {
								-- use nvim-dap-vscode-js's pwa-node debug adapter
								type = "pwa-node",
								-- launch a new process to attach the debugger to
								request = "launch",
								-- name of the debug action you have to select for this config
								name = "Launch file in new node process",
								-- launch current file
								program = "${file}",
								cwd = "${workspaceFolder}",
							}
						or nil,
				}
			end

			require("dapui").setup()
			require("nvim-dap-virtual-text").setup({})

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({ reset = true })
			end
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},
}
