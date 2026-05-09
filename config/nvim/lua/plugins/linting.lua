local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	python = { "pylint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
		lint.try_lint(nil, { cwd = client.root_dir })
	end,
})

vim.keymap.set("n", "<leader>bl", function()
	lint.try_lint(nil, { ignore_errors = true })
end, { desc = "[L]int current buffer" })
