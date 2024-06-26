local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
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
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	-- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	-- ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	-- ["f"] = {
	-- 	"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	-- 	"Find files",
	-- },
	-- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	-- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	--
	-- p = {
	-- 	name = "Packer",
	-- 	c = { "<cmd>PackerCompile<cr>", "Compile" },
	-- 	i = { "<cmd>PackerInstall<cr>", "Install" },
	-- 	s = { "<cmd>PackerSync<cr>", "Sync" },
	-- 	S = { "<cmd>PackerStatus<cr>", "Status" },
	-- 	u = { "<cmd>PackerUpdate<cr>", "Update" },
	-- },
	--
	-- l = {
	-- 	name = "LSP",
	-- 	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	-- 	d = {
	-- 		"<cmd>Telescope lsp_document_diagnostics<cr>",
	-- 		"Document Diagnostics",
	-- 	},
	-- 	w = {
	-- 		"<cmd>Telescope lsp_workspace_diagnostics<cr>",
	-- 		"Workspace Diagnostics",
	-- 	},
	-- 	f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
	-- 	i = { "<cmd>LspInfo<cr>", "Info" },
	-- 	I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	-- 	j = {
	-- 		"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
	-- 		"Next Diagnostic",
	-- 	},
	-- 	k = {
	-- 		"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
	-- 		"Prev Diagnostic",
	-- 	},
	-- 	l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
	-- 	q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
	-- 	r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	-- 	s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
	-- 	S = {
	-- 		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
	-- 		"Workspace Symbols",
	-- 	},
	-- },
	-- s = {
	-- 	name = "Search",
	-- 	c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	-- 	h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
	-- 	M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
	-- 	r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	-- 	R = { "<cmd>Telescope registers<cr>", "Registers" },
	-- 	k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
	-- 	C = { "<cmd>Telescope commands<cr>", "Commands" },
	-- },
	--
	--
	--
	--
	--

	g = {
		name = "Git",
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
		s = { "<cmd>Telescope git_status<cr>", "Git status..." },
		["co"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		["cc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	t = {
		name = "Tests",
		r = { "<cmd>lua require('neotest').run.run()<CR>", "Run nearest test" },
		d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug test" },
		f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run all tests in file" },
		s = { "<cmd>lua require('neotest').summary.toggle()<CR>", "Toggle test summary" },
		o = { "<cmd>lua require('neotest').output.open({enter = true})<CR>", "Open test output" },
		w = { "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>", "Watch file" },
		["[e"] = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", "Jump to prev failed" },
		["]e"] = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", "Jump to next failed" },
	},

	d = {
		name = "Debugging",
		c = { "<Cmd>lua require'dap'.continue()<CR>", "Continue" },
		o = { "<Cmd>lua require'dap'.step_over()<CR>", "Step over" },
		i = { "<Cmd>lua require'dap'.step_into()<CR>", "Step into" },
		t = { "<Cmd>lua require'dap'.step_out()<CR>", "Step out" },
		b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
		q = {
			"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			"Set breakpoint with condition",
		},
		l = {
			"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
			"Set log message breakpoint",
		},
		p = { "<Cmd>lua require'dap'.repl.open()<CR>", "REPL open" },
		r = { "<Cmd>lua require'dap'.run_last()<CR>", "Run last" },
	},
}

local legacy_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>f", ":Telescope git_files<CR>", legacy_opts)
vim.keymap.set("n", "<leader>z", ":Telescope find_files<CR>", legacy_opts)
vim.keymap.set("n", "<leader>u", ":Telescope buffers<CR>", legacy_opts)
-- vim.keymap.set("n", "<leader>u", ":Telescope projects<CR>", legacy_opts)
vim.keymap.set("n", "<leader>e", ":Telescope live_grep<CR>", legacy_opts)
vim.keymap.set("n", "<leader>n", ":Telescope diagnostics<CR>", legacy_opts)
-- vim.keymap.set("n", "<leader>d", ":Telescope lsp_document_symbols<CR>", legacy_opts)

which_key.setup(setup)
which_key.register(mappings, opts)
