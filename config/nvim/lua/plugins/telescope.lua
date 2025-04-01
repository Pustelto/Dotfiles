return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
			},
			-- TODO: what this do?
			-- { 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local lga_actions = require("telescope-live-grep-args.actions")
			require("telescope").setup({
				defaults = {
					prompt_prefix = "󰅂 ",
					selection_caret = "󰅂 ",
					path_display = { truncate = 3 },
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							height = 0.9,
							preview_cutoff = 20,
							prompt_position = "bottom",
							width = { 0.8, max = 150 },
						},
					},
					preview = {
						filesize_limit = 2,
					},
				},
				pickers = {
					find_files = {
						previewer = true,
						find_command = { "fd", "--type", "f", "-H" },
					},
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								-- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								-- freeze the current list and start a fuzzy search in the frozen list
								-- ["<C-space>"] = actions.to_fuzzy_refine,
							},
						},
					},
				},
				-- extensions = {
				-- 	["ui-select"] = {
				-- 		require("telescope.themes").get_dropdown(),
				-- 	},
				-- },
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "live_grep_args")
			-- pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")

			-- vim.keymap.set("n", "<leader>u", function()
			-- 	builtin.buffers({ sort_mru = true, sort_lastused = false })
			-- end, { desc = "Find existing b[U]ffers" })
			-- vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "[S]earch [F]iles" })
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>e",
			-- 	require("telescope").extensions.live_grep_args.live_grep_args,
			-- 	{ desc = "[S]earch by [G]rep" }
			-- )

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				-- builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				-- 	winblend = 10,
				-- 	previewer = false,
				-- }))
				builtin.current_buffer_fuzzy_find()
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
