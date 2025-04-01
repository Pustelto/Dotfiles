-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- TODO: I can use require("lazy").setup("plugins") to install all plugins in the plugins directory
-- migrate all config to files
require("lazy").setup({
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	-- better types when editing config files in lua
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				plugins = { "nvim-dap-ui", "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
			},
		},
	},

	-- Colorschemes
	-- { "marko-cerovac/material.nvim", lazy = true },
	-- {
	-- 	dir = "~/Documents/WebDev/moonrakers-theme",
	-- 	name = "moonrakers",
	-- 	-- lazy = true,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd.colorscheme("moonrakers")
	-- 	end,
	-- },
	require("plugins/colorscheme"),

	-- Utility plugins
	"tpope/vim-surround", -- auto surround for brackets and quotes
	"tpope/vim-repeat",
	{ "windwp/nvim-autopairs", opts = {} }, -- automatically add closing brackets and quotes
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	require("plugins/ctrlxa"),
	require("plugins/which-key"),
	require("plugins/oil"),
	require("plugins/treesitter"),
	require("plugins/colorizer"),

	-- UI related plugins
	require("plugins/indentline"), -- show indent lines and highlight curent indent level
	require("plugins/telescope"),
	require("plugins/cmp"),
	require("plugins/lualine"),
	require("plugins/nvim-tree"),

	-- Better comments
	require("plugins/comments"),
	require("plugins/todo-comments"),

	-- Git related plugins
	require("plugins/gitsigns"),
	require("plugins/lazygit"),
	require("plugins/fugitive"),

	-- LSP related plugins for IDE like capabilities
	require("plugins/mason"),
	require("plugins/lsp"),
	require("plugins/linting"),
	require("plugins/formatting"),
	require("plugins/debugging"),

	-- better TS errors
	{ "dmmulroy/ts-error-translator.nvim", opts = {} },

	-- Other plugins
	require("plugins/copilot"),
	require("plugins/copilotchat"),

	-- notify
	-- Dashboard
	-- emmet
	-- theme

	-- local icons = {
	--   misc = {
	--     dots = "󰇘",
	--   },
	--   diagnostics = {
	--     Error = " ",
	--     Warn  = " ",
	--     Hint  = " ",
	--     Info  = " ",
	--   },
	--   git = {
	--     added    = " ",
	--     modified = " ",
	--     removed  = " ",
	--   },
	--   kinds = {
	--     Array         = " ",
	--     Boolean       = "󰨙 ",
	--     Class         = " ",
	--     Codeium       = "󰘦 ",
	--     Color         = " ",
	--     Control       = " ",
	--     Collapsed     = " ",
	--     Constant      = "󰏿 ",
	--     Constructor   = " ",
	--     Copilot       = " ",
	--     Enum          = " ",
	--     EnumMember    = " ",
	--     Event         = " ",
	--     Field         = " ",
	--     File          = " ",
	--     Folder        = " ",
	--     Function      = "󰊕 ",
	--     Interface     = " ",
	--     Key           = " ",
	--     Keyword       = " ",
	--     Method        = "󰊕 ",
	--     Module        = " ",
	--     Namespace     = "󰦮 ",
	--     Null          = " ",
	--     Number        = "󰎠 ",
	--     Object        = " ",
	--     Operator      = " ",
	--     Package       = " ",
	--     Property      = " ",
	--     Reference     = " ",
	--     Snippet       = " ",
	--     String        = " ",
	--     Struct        = "󰆼 ",
	--     TabNine       = "󰏚 ",
	--     Text          = " ",
	--     TypeParameter = " ",
	--     Unit          = " ",
	--     Value         = " ",
	--     Variable      = "󰀫 ",
	--   },
	-- },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
