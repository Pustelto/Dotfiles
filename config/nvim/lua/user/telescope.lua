local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local putils = require("telescope.previewers.utils")

telescope.setup({
	defaults = {
		prompt_prefix = "> ",
		selection_caret = "> ",
		initial_mode = "insert",
		path_display = { truncate = 3 },
		file_ignore_patterns = { "node_modules", ".git", ".DS_Store", "dist", "yarn.lock", "_build" },
		--[[ theme = "dropdown", ]]
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				height = 0.9,
				preview_cutoff = 20,
				prompt_position = "bottom",
				width = 0.6,
			},
			center = {
				height = 0.7,
				width = 0.7,
			},
		},
		cache_picker = {
			num_pickers = 5,
		},
		preview = {
			filesize_limit = 2,
			-- 1) Do not show previewer for certain files
			-- filetype_hook = function(filepath, bufnr, opts)
			-- 	-- you could analogously check opts.ft for filetypes
			-- 	local excluded = vim.tbl_filter(function(ending)
			-- 		return filepath:match(ending)
			-- 	end, {
			-- 		".*%.graphql$",
			-- 			""
			-- 	})
			-- 	if not vim.tbl_isempty(excluded) then
			-- 		putils.set_preview_message(
			-- 			bufnr,
			-- 			opts.winid,
			-- 			string.format("Preview disabled for %s files!", excluded[1]:sub(5, -1))
			-- 		)
			-- 		return false
			-- 	end
			-- 	return true
			-- end,
		},
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		find_files = {
			--[[ hidden = true, ]]
			--[[ no_ignore = true, ]]
			previewer = false,
			find_command = { "fd", "--type", "f", "-H", "-I" },
		},
		git_files = {},
	},
	--[[ extensions = { ]]
	--[[ 	fzf = { ]]
	--[[ 		fuzzy = true, -- false will only do exact matching ]]
	--[[ 		override_generic_sorter = true, -- override the generic sorter ]]
	--[[ 		override_file_sorter = true, -- override the file sorter ]]
	--[[ 		case_mode = "ignore_case", -- or "ignore_case" or "respect_case" ]]
	--[[ 		-- the default case_mode is "smart_case" ]]
	--[[ 	}, ]]
	--[[ }, ]]
})

telescope.load_extension("fzf")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>f", ":Telescope git_files<CR>", opts)
vim.keymap.set("n", "<leader>z", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>t", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>u", ":Telescope projects<CR>", opts)
vim.keymap.set("n", "<leader>e", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>n", ":Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>d", ":Telescope lsp_document_symbols<CR>", opts)
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
