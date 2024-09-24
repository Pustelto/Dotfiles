return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			local conform = require("conform")
			local prettier_fmts = { "prettierd", "prettier", stop_after_first = true, quiet = true }

			conform.setup({
				formatters_by_ft = {
					javascript = prettier_fmts,
					typescript = prettier_fmts,
					javascriptreact = prettier_fmts,
					typescriptreact = prettier_fmts,
					svelte = prettier_fmts,
					css = prettier_fmts,
					html = prettier_fmts,
					json = prettier_fmts,
					yaml = prettier_fmts,
					markdown = prettier_fmts,
					graphql = prettier_fmts,
					liquid = prettier_fmts,
					lua = { "stylua" },
					python = { "isort", "black" },
				},
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_fallback = true }
				end,
				notify_on_error = false,
				notify_no_formatters = true,
			})
		end,
	},
}
