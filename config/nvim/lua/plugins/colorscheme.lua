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
vim.api.nvim_set_hl(
	0,
	"DiagnosticDeprecated",
	{ strikethrough = true, fg = "#a0a0a0", cterm = { strikethrough = true } }
)
