-- nvim-treesitter (main branch).
-- Parser install/update is handled by the PackChanged autocmd in pack.lua.

local parsers = {
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
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"prisma",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

local ts = require("nvim-treesitter")
ts.setup({})

-- Ensure parsers are present (idempotent — fast no-op when up-to-date).
pcall(function()
	local job = ts.install(parsers)
	if job and job.wait then
		-- Don't block startup — let it install in the background.
		vim.schedule(function()
			job:wait(60000)
		end)
	end
end)

-- Start highlight + treesitter-driven indent for any filetype with a parser.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("nvim-treesitter-attach", { clear = true }),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end
		if pcall(vim.treesitter.start, args.buf) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

-- Textobjects (main branch new API).
require("nvim-treesitter-textobjects").setup({})

local select = require("nvim-treesitter-textobjects.select")
local function pick(query)
	return function()
		select.select_textobject(query, "textobjects")
	end
end
vim.keymap.set({ "x", "o" }, "af", pick("@function.outer"), { desc = "a function" })
vim.keymap.set({ "x", "o" }, "if", pick("@function.inner"), { desc = "inner function" })
vim.keymap.set({ "x", "o" }, "ac", pick("@class.outer"), { desc = "a class" })
vim.keymap.set({ "x", "o" }, "ic", pick("@class.inner"), { desc = "inner class" })
vim.keymap.set({ "x", "o" }, "as", function()
	select.select_textobject("@scope", "locals")
end, { desc = "language scope" })

local move = require("nvim-treesitter-textobjects.move")
vim.keymap.set({ "n", "x", "o" }, "]m", function()
	move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })
vim.keymap.set({ "n", "x", "o" }, "]M", function()
	move.goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })
vim.keymap.set({ "n", "x", "o" }, "[m", function()
	move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[M", function()
	move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })

local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<leader>a", function()
	swap.swap_next("@parameter.inner")
end, { desc = "Swap next parameter" })
vim.keymap.set("n", "<leader>A", function()
	swap.swap_previous("@parameter.inner")
end, { desc = "Swap previous parameter" })

-- Context (toggleable via <leader>wt).
require("treesitter-context").setup({
	enable = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 5,
	trim_scope = "outer",
	mode = "topline",
	separator = nil,
	zindex = 20,
	on_attach = nil,
})
