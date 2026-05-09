local theme = require("moonrakers.theme")

local M = {}

-- M._options = nil
function M._load()
	M.load()
end

function M.load()
	theme.apply()
	if vim.g.colors_name then
		vim.cmd("highlight clear")
	end

	local a = 532

	vim.o.termguicolors = true
	vim.g.colors_name = "moonrakers"
end

-- function M.setup() end

return M
