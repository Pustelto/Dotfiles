return {
  -- This works only for line comments, not block comments, I still find original commenting better
	-- {
	-- 	"folke/ts-comments.nvim",
	-- 	opts = {},
	-- 	event = "VeryLazy",
	-- 	enabled = vim.fn.has("nvim-0.10.0") == 1,
	-- },
	-- Use this in older VIM verisions
	{
		"numToStr/Comment.nvim",
		opts = {},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
		-- enabled = vim.fn.has("nvim-0.10.0") == 0,
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {},
		-- enabled = vim.fn.has("nvim-0.10.0") == 0,
	},
}
