local lualine = require("lualine")

local mode = {
	"mode",
	fmt = function(str)
		return str:sub(1, 3):upper()
	end,
}

local filename = {
	"filename",
	file_status = true,
	path = 1,
	fmt = function(name)
		local numwidth = vim.api.nvim_get_option_value("numberwidth", {})
		local signswidth = 0
		if vim.api.nvim_get_option_value("signcolumn", {}) == "yes" then
			signswidth = 1
		end
		local padding = numwidth + signswidth
		return string.rep(" ", padding) .. name
	end,
	symbols = {
		modified = "[+]",
		readonly = "[-]",
		unnamed = "[No Name]",
		newfile = "[New]",
	},
	color = { fg = "#A9B1D6", bg = "#1A1B26", gui = "" },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local fileformat = {
	"fileformat",
	fmt = function(str)
		local filesymbols = {
			unix = "",
			dos = "",
			mac = "",
		}
		return filesymbols[str]
	end,
	padding = { left = 1, right = 2.5 },
}

local location = {
	"location",
	padding = { left = 0, right = 1 },
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local spaces = function()
	local tab = vim.bo.expandtab
	local width = vim.bo.shiftwidth
	if tab then
		return "spaces: " .. width
	else
		return "tabs: " .. width
	end
end

lualine.setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch },
		lualine_c = { diagnostics },
		lualine_x = {
			"copilot",
			spaces,
			"encoding",
			fileformat,
		},
		lualine_y = { filetype },
		lualine_z = { "progress", location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
