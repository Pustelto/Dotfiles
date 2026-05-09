-- LSP behaviour shared across all servers.
-- Per-server config lives in ../../lsp/<name>.lua and is wired up via
-- vim.lsp.enable() in init.lua.

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/schemastore.nvim",
		},
		config = function()
			local sev = vim.diagnostic.severity
			local virtual_text = {
				spacing = 2,
				source = "if_many",
				severity = sev.ERROR,
			}

			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				virtual_text = virtual_text,
				signs = {
					text = {
						[sev.ERROR] = "\u{f057}",
						[sev.WARN] = "\u{f071}",
						[sev.HINT] = "\u{f0eb}",
						[sev.INFO] = "\u{f05a}",
					},
					numhl = {
						[sev.ERROR] = "DiagnosticSignError",
						[sev.WARN] = "DiagnosticSignWarn",
						[sev.HINT] = "DiagnosticSignHint",
						[sev.INFO] = "DiagnosticSignInfo",
					},
				},
				float = {
					focusable = true,
					style = "minimal",
					border = "none",
					source = true,
					header = "",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Pickers via Telescope (will be re-routed to Snacks in step 7).
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gu", require("telescope.builtin").lsp_references, "[G]oto [U]sage")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map(
						"<leader>ps",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"Works[P]ace [S]ymbols"
					)

					map("<leader>re", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("<leader>ld", vim.diagnostic.open_float, "Show line diagnostics")
					map("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Go to previous diagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Go to next diagnostic")

					-- TypeScript-specific code actions.
					map("<leader>p", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.addMissingImports.ts" },
								diagnostics = {},
							},
						})
					end, "Add missing imports")
					map("<leader>o", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.organizeImports.ts" },
								diagnostics = {},
							},
						})
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.sortImports.ts" },
								diagnostics = {},
							},
						})
					end, "Organize imports")
					map("<leader>lu", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.removeUnusedImports.ts" },
								diagnostics = {},
							},
						})
					end, "Remove unused imports")

					-- Document highlight: highlight references of the symbol under cursor on hold.
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/documentHighlight") then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client:supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
						map("<leader>wl", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end

					map("<leader>wx", function()
						local current_state = vim.diagnostic.config().virtual_text
						if current_state then
							vim.diagnostic.config({ virtual_text = not current_state })
						else
							vim.diagnostic.config({ virtual_text = virtual_text })
						end
					end, "Toggle Virtual Te[X]t")
				end,
			})
		end,
	},
}
