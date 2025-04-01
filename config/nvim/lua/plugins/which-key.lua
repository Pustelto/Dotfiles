return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup({
				plugins = {
					marks = true, -- shows a list of your marks on ' and `
					registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
					presets = {
						operators = false, -- adds help for operators like d, y, ...
						motions = false, -- adds help for motions
						text_objects = true, -- help for text objects triggered after entering an operator
						windows = true, -- default bindings on <c-w>
						z = true, -- bindings for folds, spelling and others prefixed with z
						g = true, -- bindings for prefixed with g
					},
				},
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				win = {
					border = "none", -- none, single, double, shadow
					padding = { 2, 2 }, -- extra window padding [top, right, bottom, left]
					wo = {
						winblend = 0,
					},
				},
				layout = {
					height = { min = 5, max = 25 }, -- min and max height of the columns
					width = { min = 30, max = 50 }, -- min and max width of the columns
					spacing = 10, -- spacing between columns
					align = "left", -- align columns left, center or right
				},
				filter = function(mapping)
					-- example to exclude mappings without a description
					-- return mapping.desc and mapping.desc ~= ""
					return true
				end,
				triggers = {
					{ "<auto>", mode = "no" },
					{ "<leader>", mode = { "n", "v" } },
				},
				delay = 400,
				show_help = true, -- show help message on the command line when the popup is visible
				notify = true,
			})

			-- Document existing key chains
			-- require("which-key").register({
			-- 	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			-- 	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			-- 	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			-- 	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- 	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			-- 	["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			-- 	["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			-- })
			local opts = { mode = "n" }

			local builtin = require("telescope.builtin")

			require("which-key").add({
				{
					{
						"<leader>?",
						function()
							require("which-key").show({ global = false })
						end,
						desc = "Buffer Local Keymaps (which-key)",
					},
					--
					-- GIT GROUP
					{ "<leader>g", group = "[G]it" },
					{ "<leader>gs", "<cmd>LazyGit<cr>", desc = "LazyGit" },
					{ "<leader>gA", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc = "Stage file" },
					{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
					{ "<leader>ga", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
					{ "<leader>gb", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
					-- { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
					{ "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Go to next hunk" },
					{ "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Go to prev hunk" },
					{
						"<leader>gl",
						"<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>",
						desc = "Toggle line git blame",
					},
					{ "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview hunk" },
					{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
					{ "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
					--
					-- SEACH GROUP
					{ "<leader>s", group = "[S]earch" },
					{ "<leader>sc", builtin.colorscheme, desc = "[S]earch [C]olorscheme" },
					-- { "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
					{ "<leader>sh", builtin.help_tags, desc = "[S]earch [H]elp" },
					{ "<leader>sm", builtin.commands, desc = "[S]earch Co[M]mands" },
					{
						"<leader>so",
						function()
							builtin.oldfiles({ cwd_only = true })
						end,
						desc = "[S]earch [O]ldfiles",
					},
					--
					-- TEST GROUP
					-- { "<leader>t", group = "[T]ests" },
					-- { "<leader>t[e", "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", desc = "Jump to prev failed", },
					-- { "<leader>t]e", "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", desc = "Jump to next failed", },
					-- { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "Debug test", },
					-- { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run all tests in file", },
					-- { "<leader>to", "<cmd>lua require('neotest').output.open({enter = true})<CR>", desc = "Open test output", },
					-- { "<leader>tr", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run nearest test" },
					-- { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle test summary" },
					-- { "<leader>tw", "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>", desc = "Watch file", },

					--
					-- TOGGLE SETTINGS GROUP
					{ "<leader>w", group = "Toggle" },
					{ "<leader>wf", "<cmd>FormatToggle<CR>", desc = "Toggle File Formatting on Save" },
					{ "<leader>wt", "<cmd>TSContextToggle<CR>", desc = "Toggle Treesitter scope con[T]ext" },
					-- { "<leader>wl", "", desc = "Toggle inlay hints", },                  -- Defined in lsp.lua
					-- { "<leader>wx", "", desc = "Toggle diagnostic virtual text", },      -- Defined in lsp.lua
					{
						"<leader>wd",
						function()
							vim.diagnostic.enable(not vim.diagnostic.is_enabled())
						end,
						desc = "Toggle [D]iagnostics",
					},
					{
						"<leader>wg",
						function()
							require("gitsigns").toggle_signs()
						end,
						desc = "Toggle [G]it Signs",
					},
					{ "<leader>wc", "<cmd>ColorizerToggle<CR>", desc = "Toggle color preview" },
					-- { "<leader>wd", "<cmd>TSContextToggle<CR>", desc = "Toggle presentation mode" },
				},
				--
				-- BUFFER SETTINGS GROUP
				{ "<leader>b", group = "Buffer/Document" },
				{ "<leader>bs", require("telescope.builtin").lsp_document_symbols, desc = "[D]ocument [S]ymbols" }, -- Fuzzy find all the symbols in your current document. Symbols are things like variables, functions, types, etc.
				{ "<leader>bd", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "[B]uffer [D]iagnostics" },
				{
					"<leader>bf",
					function()
						require("conform").format({
							lsp_fallback = true,
							async = false,
							timeout_ms = 500,
						})
					end,
					desc = "[B]uffer [F]ormat (or range in V)",
				},
				-- { "<leader>bl", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "[B]uffer [L]int" },
				--
				-- DEBUGGING GROUP
				{ "<leader>d", group = "[D]ebugging" },
				{ "<leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
				{ "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>", desc = "Continue" },
				{ "C-8", "<Cmd>lua require'dap'.step_over()<CR>", group = "[D]ebugging", desc = "Step over" },
				{ "C-9", "<Cmd>lua require'dap'.step_into()<CR>", group = "[D]ebugging", desc = "Step into" },
				{ "C-7", "<Cmd>lua require'dap'.step_out()<CR>", group = "[D]ebugging", desc = "Step out" },
				{ "<leader>dt", "<Cmd>lua require'dap'.terminate()<CR>", desc = "Terminate" },
			}, opts)
		end,
	},
}
