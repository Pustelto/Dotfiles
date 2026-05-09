require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "-" },
		topdelete = { text = "^^" },
		changedelete = { text = "▎" },
		untracked = { text = "│" },
	},
	signs_staged_enable = false,
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
})
