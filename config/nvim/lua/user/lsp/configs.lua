local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = {
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"vimls",
	"cssls",
	"bashls",
	"graphql",
	"html",
	"yamlls",
	"remark_ls",
	"emmet_ls",
	"dockerls",
}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	if server == "tsserver" then
		require("typescript").setup({
			server = {
				on_attach = opts.on_attach,
				capabilities = opts.capabilities,
			},
		})
	else
		lspconfig[server].setup(opts)
	end
end
