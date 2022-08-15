local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.formatting.prettierd.with({ prefer_local = "node_modules/.bin" }),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
			-- cwd = function(params) return vim.fn.expand("%:p:h") end
		}),
		null_ls.builtins.code_actions.eslint.with({ prefer_local = "node_modules/.bin" }),
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})