return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = {
					text = "^^",
				},
				changedelete = {
					text = "▎",
				},
				-- untracked = { hl = "GitSignsAdd", text = "▎" },
				untracked = { text = "│" },
			},
			signs_staged_enable = false,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
		},
	},
}
