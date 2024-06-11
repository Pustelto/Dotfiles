return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			colors = {
				error = { "#F7454B" },
				warning = { "#ffcb6b" },
				info = { "#89ddff" },
			},
			highlight = {
				keyword = "bg",
				after = "fg", -- "fg" or "bg" or empty
			},
		},
	},
}
