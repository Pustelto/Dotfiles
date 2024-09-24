return {
	{
		"Equilibris/nx.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},

		opts = {
			-- See below for config options
			nx_cmd_root = "pnpm nx",
		},

		-- Plugin will load when you use these keys
		keys = {
			{ "<leader>x", "<cmd>Telescope Nx actions<CR>", desc = "Nx actions" },
		},
	},
}
