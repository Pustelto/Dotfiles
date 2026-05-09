local function highlight(group, opts)
	opts.default = opts.default or false
	vim.api.nvim_set_hl(0, group, opts)
end

local colors = {
	["Background"] = "#29203d",
	["Foreground"] = "#feffff",
	["black"] = "#283137",
	["red"] = "#e2004b",
	["red2"] = "#eb5661",
	["green"] = "#a9c357",
	["yellow"] = "#f7be33",
	["blue"] = "#62c7f1",
	["magenta"] = "#e173e4",
	["cyan"] = "#7fdcf5",
	["white"] = "#e3dee0",
	["white2"] = "#bdc6e3",
	["orange"] = "#f28c40",
	["orange2"] = "#eb974d",
	["deep_black"] = "#1a1532",
	["purple_black"] = "#23192c",
	["light_black"] = "#a6bbcd",
	["paleblue"] = "#87c5e0",
	["pink"] = "#f27e86",
	["red_dimmed"] = "#ec5960",
	["gray"] = "#d1d3e2",
	["gray1"] = "#5a5f77",
	["gray3"] = "#40425D",
	["gray2"] = "#39344B",
	["magenta_dimmed"] = "#B16EB9",
	["not working"] = "#FF0000",
	["bg_2"] = "#322A3F",
	["bg_3"] = "#28353e",
}

local M = {}

function M.apply()
	highlight("Normal", { fg = colors["white"], bg = colors["Background"] })
	highlight("Cursor", { fg = colors["yellow"] })
	highlight("LineNumber", { fg = colors["gray1"] })
	highlight("LineNumberCursor", { fg = colors["Foreground"] })
	highlight("Selection", { bg = colors["gray2"] })
	highlight("CursorLine", { bg = colors["deep_black"] })

	highlight("Comment", { fg = colors["gray1"] })
	highlight("String", { fg = colors["green"] })
	highlight("Number", { fg = colors["orange"] })
	highlight("Boolean", { fg = colors["red2"] })
	highlight("Function", { fg = colors["cyan"] })
	highlight("Keyword", { fg = colors["magenta_dimmed"] })
	highlight("Operator", { fg = colors["operator"] })
	highlight("Type", { fg = colors["yellow"] })
	highlight("Variable", { fg = colors["paleblue"] })
	highlight("Property", { fg = colors["pink"] })
	highlight("Special", { fg = colors["red_dimmed"] })

	highlight("@punctuation", { fg = colors["white2"] })
	highlight("@variable", { fg = colors["cyan"] })
	highlight("@type", { fg = colors["yellow"] })
	highlight("@type.builtin", { fg = colors["yellow"] })
	highlight("@operator", { fg = colors["gray"] })
	highlight("@tag.delimiter", { fg = colors["white2"] })
	highlight("@tag", { fg = colors["yellow"] })
	highlight("@tag.builtin", { fg = colors["red_dimmed"] })
	highlight("@tag.attribute", { fg = colors["white2"] })

	highlight("@tag.builtin.tsx", { fg = colors["red_dimmed"] })
	highlight("@variable.tsx", { link = "@variable" })
	highlight("@type.tsx", { link = "@type" })

	-- highlight("TSType", { fg = colors["paleblue"] })
	-- highlight("TSProperty", { fg = colors["yellow"] })
	-- highlight("JSXTag", { fg = colors["red2"] })
	-- highlight("JSXComponent", { fg = colors["cyan"] })
	-- highlight("JSXAttribute", { fg = colors["magenta_dimmed"] })

	highlight("DiagnosticError", { fg = colors["undefined"] })
	highlight("DiagnosticWarn", { fg = colors["undefined"] })
	highlight("DiagnosticInfo", { fg = colors["undefined"] })
	highlight("DiagnosticHint", { fg = colors["undefined"] })
end

return M
