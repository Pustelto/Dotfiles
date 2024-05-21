local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		document_highlight = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "single",
			source = "always",
			header = "",
			prefix = function(diagnostic)
				local diag_to_format = {
					[vim.diagnostic.severity.ERROR] = { "Error", "LspDiagnosticsDefaultError" },
					[vim.diagnostic.severity.WARN] = { "Warning", "LspDiagnosticsDefaultWarning" },
					[vim.diagnostic.severity.INFO] = { "Info", "LspDiagnosticsDefaultInfo" },
					[vim.diagnostic.severity.HINT] = { "Hint", "LspDiagnosticsDefaultHint" },
				}
				local res = diag_to_format[diagnostic.severity]
				return string.format("(%s) ", res[1]), res[2]
			end,
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "single",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { silent = true }
	vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)

	local bufopts = { silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	vim.keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	vim.keymap.set("n", "gu", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
	vim.keymap.set("n", "<leader>sg", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "<leader>re", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	-- vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
	-- vim.keymap.set("n", "<leader>w", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", bufopts)
	vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
	vim.keymap.set("n", "<leader>gm", "<cmd>TypescriptAddMissingImports<CR>", bufopts)
	vim.keymap.set("n", "<leader>p", function()
		require("typescript").actions.addMissingImports({ sync = true })
		require("typescript").actions.removeUnused({ sync = true })
		require("typescript").actions.organizeImports({ sync = true })
		-- vim.lsp.buf.formatting_sync()
	end, { silent = true, desc = "Organize imports" })
	-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end
	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end
	if client.name == "remark_ls" then
		client.server_capabilities.document_formatting = false
	end
	if client.name == "jsonls" then
		client.server_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local fidget_ok, fidget = pcall(require, "fidget")
if fidget_ok then
	fidget.setup()
end

return M
