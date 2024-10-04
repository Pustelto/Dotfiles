return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
			}
			-- require('lint').linters.your_linter_name = {
			--   cmd = 'linter_cmd',
			--   stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
			--   append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
			--   args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
			--   stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
			--   ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
			--   env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
			--   parser = your_parse_function
			-- }
			-- lint.linters.eslint_d = {
			-- 	args = {
			-- 		"--format",
			-- 		"json",
			-- 		"--stdin",
			-- 		"--stdin-filename",
			-- 		function()
			-- 			return vim.api.nvim_buf_get_name(0)
			-- 		end,
			-- 	},
			-- ignore_exitcode = true,
			-- cmd = "eslint_d",
			-- rootPatterns = { ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml" },
			-- debounce = 100,
			-- args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
			-- parseJson = {
			-- 	errorsRoot = "[0].messages",
			-- 	line = "line",
			-- 	column = "column",
			-- 	endLine = "endLine",
			-- 	endColumn = "endColumn",
			-- 	message = "${message} [${ruleId}]",
			-- 	security = "severity",
			-- },
			-- securities = {
			-- 	[2] = "error",
			-- 	[1] = "warning",
			-- },
			-- }

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
					local client = get_clients({ bufnr = 0 })[1] or {}
					lint.try_lint(nil, { cwd = client.root_dir })
					-- lint.try_lint(nil, { ignore_errors = true })
				end,
			})

			vim.keymap.set("n", "<leader>bl", function()
				lint.try_lint(nil, { ignore_errors = true })
			end, { desc = "[L]int current buffer" })
		end,
	},
}
