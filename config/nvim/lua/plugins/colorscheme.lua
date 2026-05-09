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
			require("tokyonight").setup({
				style = "storm",
				on_highlights = function(highlights, colors)
					highlights.LineNr = { fg = colors.comment }
					highlights.LineNrAbove = { fg = colors.comment }
					highlights.LineNrBelow = { fg = colors.comment }
					highlights.CursorLineNr = { fg = colors.green1, bold = false }
				end,
			})
			vim.cmd.colorscheme("tokyonight-storm")
			-- vim.cmd.hi("Comment gui=none")
			vim.api.nvim_set_hl(
				0,
				"DiagnosticDeprecated",
				{ strikethrough = true, fg = "#a0a0a0", cterm = { strikethrough = true } }
			)
			-- vim.api.nvim_set_hl(
			--   0,
			--   "LineNr",
			--   { fg = "#4b5263" }
			-- )
			-- vim.api.nvim_set_hl(
			--   0,
			--   "CursorLineNr",
			--   { fg = "#c0caf5", bold = true }
			-- )

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
