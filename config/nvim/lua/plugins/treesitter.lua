return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"diff",
				"dockerfile",
				"go",
				"graphql",
				"html",
				"http",
				"javascript",
				"json",
				"json5",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"prisma",
				"scss",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			autopairs = {
				enable = true,
			},
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		enabled = true,
		config = function()
			local opts = {
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- -- You can choose the select mode (default is charwise 'v')
						-- --
						-- -- Can also be a function which gets passed a table with the keys
						-- -- * query_string: eg '@function.inner'
						-- -- * method: eg 'v' or 'o'
						-- -- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- -- mapping query_strings to modes.
						-- selection_modes = {
						-- 	["@parameter.outer"] = "v", -- charwise
						-- 	["@function.outer"] = "V", -- linewise
						-- 	["@class.outer"] = "<c-v>", -- blockwise
						-- },
						-- -- If you set this to `true` (default is `false`) then any textobject is
						-- -- extended to include preceding or succeeding whitespace. Succeeding
						-- -- whitespace has priority in order to act similarly to eg the built-in
						-- -- `ap`.
						-- --
						-- -- Can also be a function which gets passed a table with the keys
						-- -- * query_string: eg '@function.inner'
						-- -- * selection_mode: eg 'v'
						-- -- and should return true or false
						-- include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							-- 	["]]"] = { query = "@class.outer", desc = "Next class start" },
							-- 	--
							-- 	-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							-- 	["]o"] = "@loop.*",
							-- 	-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							-- 	--
							-- 	-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- 	-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							-- 	["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							-- 	["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							-- ["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							-- ["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							-- ["[]"] = "@class.outer",
						},
						-- -- Below will go to either the start or the end, whichever is closer.
						-- -- Use if you want more granular movements
						-- -- Make it even more gradual by adding multiple queries and regex.
						-- goto_next = {
						-- 	["]d"] = "@conditional.outer",
						-- },
						-- goto_previous = {
						-- 	["[d"] = "@conditional.outer",
						-- },
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			}
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 5, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
