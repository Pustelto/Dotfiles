return {
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	-- Use this in older VIM verisions
	-- TODO: delete once I migrate to nvim 0.10.0
	{
		"numToStr/Comment.nvim",
		opts = {},
		enabled = vim.fn.has("nvim-0.10.0") == 0,
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {},
		enabled = vim.fn.has("nvim-0.10.0") == 0,
	},
}
