return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "AndreM222/copilot-lualine" },
		event = "VeryLazy",
		config = function()
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
				fmt = function(filename)
					local numwidth = vim.api.nvim_get_option_value("numberwidth", {})
					local signswidth = 0
					if vim.api.nvim_get_option_value("signcolumn", {}) == "yes" then
						signswidth = 1
					end
					local padding = numwidth + signswidth

					return string.rep(" ", padding) .. filename
				end,
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]",
				},
				color = { fg = "#A9B1D6", bg = "#1A1B26", gui = "" },
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = " ", warn = " " },
				colored = false,
				update_in_insert = false,
				always_visible = true,
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = "",
			}

			local fileformat = {
				"fileformat",
				fmt = function(str)
					local filesymbols = {
						unix = "", -- e712
						dos = "", -- e70f
						mac = "", -- e711
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

			-- Function that will show if VIM uses spaces or tabs for indentation and how wide the space is
			-- it will get those options from the vim settings.
			-- Expected output: "spaces: 2" or "tabs: 4"
			local spaces = function()
				local tab = vim.api.nvim_buf_get_option(0, "expandtab")
				local width = vim.api.nvim_buf_get_option(0, "shiftwidth")
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
					lualine_c = {
						diagnostics,
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = { fg = "#ff9e64" },
						},
					},
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
					lualine_c = {
						filename,
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						filename,
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				-- tabline = {},
				-- extensions = {},
			})
		end,
	},
}
