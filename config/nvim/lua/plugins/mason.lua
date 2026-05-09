-- Mason v2.x: installs LSP server binaries and other tools.
-- Server activation is done explicitly via vim.lsp.enable() in init.lua,
-- so we set automatic_enable = false on mason-lspconfig.
return {
	{
		"mason-org/mason.nvim",
		version = "^2.0.0",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		version = "^2.0.0",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"rust_analyzer",
				"dockerls",
				"yamlls",
				"bashls",
				"vimls",
				"jsonls",
			},
			automatic_enable = false,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettierd",
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
				"rustfmt",
			},
		},
	},
}
