return {
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
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
				popup_mappings = {
					scroll_down = "<c-d>", -- binding to scroll down inside the popup
					scroll_up = "<c-u>", -- binding to scroll up inside the popup
				},
				window = {
					border = "none", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
					padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
					winblend = 0,
				},
				layout = {
					height = { min = 5, max = 25 }, -- min and max height of the columns
					width = { min = 30, max = 50 }, -- min and max width of the columns
					spacing = 10, -- spacing between columns
					align = "left", -- align columns left, center or right
				},
				ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
				show_help = true, -- show help message on the command line when the popup is visible
				triggers = "auto", -- automatically setup triggers, use `triggers = {"<leader>"}` to specify list manually
				triggers_blacklist = {
					i = { "j", "k" },
					v = { "j", "k" },
				},
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

			require("which-key").register({
				["<leader>g"] = {
					name = "[G]it",
					b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
					l = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle line git blame" },
					j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Go to next hunk" },
					k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Go to prev hunk" },
					p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview hunk" },
					r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
					R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
					a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
					A = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage file" },
					u = {
						"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
						"Undo Stage Hunk",
					},
					s = { "<cmd>vert G<cr>", "Git status..." },
					d = {
						"<cmd>Gitsigns diffthis HEAD<cr>",
						"Diff",
					},
				},
				["<leader>t"] = {
					name = "[T]ests",
					r = { "<cmd>lua require('neotest').run.run()<CR>", "Run nearest test" },
					d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug test" },
					f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run all tests in file" },
					s = { "<cmd>lua require('neotest').summary.toggle()<CR>", "Toggle test summary" },
					o = { "<cmd>lua require('neotest').output.open({enter = true})<CR>", "Open test output" },
					w = { "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>", "Watch file" },
					["[e"] = {
						"<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>",
						"Jump to prev failed",
					},
					["]e"] = {
						"<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>",
						"Jump to next failed",
					},
				},
				["<leader>w"] = {
					name = "Toggle",
					f = { "<cmd>FormatToggle<CR>", "Toggle file formatting" },
				},
				["<leader>s"] = {
					name = "[S]earch",
					h = { builtin.help_tags, "[S]earch [H]elp" },
					o = {
						function()
							builtin.oldfiles({ cwd_only = true })
						end,
						"[S]earch [O]ldfiles",
					},
					c = { builtin.colorscheme, "[S]earch [C]olorscheme" },
					d = { builtin.diagnostics, "[S]earch [D]iagnostics" },
					m = { builtin.commands, "[S]earch Co[M]mands" },
				},
				-- TODO: setup DAP first
				-- d = {
				-- 	name = "Debugging",
				-- 	c = { "<Cmd>lua require'dap'.continue()<CR>", "Continue" },
				-- 	o = { "<Cmd>lua require'dap'.step_over()<CR>", "Step over" },
				-- 	i = { "<Cmd>lua require'dap'.step_into()<CR>", "Step into" },
				-- 	t = { "<Cmd>lua require'dap'.step_out()<CR>", "Step out" },
				-- 	b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
				-- 	q = {
				-- 		"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				-- 		"Set breakpoint with condition",
				-- 	},
				-- 	l = {
				-- 		"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				-- 		"Set log message breakpoint",
				-- 	},
				-- 	p = { "<Cmd>lua require'dap'.repl.open()<CR>", "REPL open" },
				-- 	r = { "<Cmd>lua require'dap'.run_last()<CR>", "Run last" },
				-- },
			}, opts)
		end,
	},
}
