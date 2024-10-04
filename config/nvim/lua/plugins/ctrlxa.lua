return {
	{
		"Konfekt/vim-CtrlXA",
		config = function()
			vim.g.CtrlXA_Toggles = {
				{ "true", "false" },
				{ "True", "False" },
				{ "TRUE", "FALSE" },
				{ "yes", "no" },
				{ "Yes", "No" },
				{ "YES", "NO" },
				{ "on", "off" },
				{ "On", "Off" },
				{ "ON", "OFF" },
				{ "set", "unset" },
				{ "||", "&&" },
				{ "!==", "===" },
				{ "undefined", "null" },
				{ "const", "let" },
			}
		end,
	},
}
