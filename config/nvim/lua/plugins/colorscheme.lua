return {
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- # Tokyonight
			vim.cmd.colorscheme("tokyonight-storm")
			vim.cmd.hi("Comment gui=none")
			vim.api.nvim_set_hl(
				0,
				"DiagnosticDeprecated",
				{ strikethrough = true, fg = "#a0a0a0", cterm = { strikethrough = true } }
			)
			--
			-- # Material
			-- vim.cmd.colorscheme("material")
			--
			-- # Zellner - light for projector
			-- vim.cmd.colorscheme("zellner")

			-- Custom color scheme
			-- vim.cmd.colorscheme("moonrakers")
		end,
	},
}
