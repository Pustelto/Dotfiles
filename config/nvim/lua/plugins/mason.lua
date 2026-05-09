require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
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
})

require("mason-tool-installer").setup({
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
})
