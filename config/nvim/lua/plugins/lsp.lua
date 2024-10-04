return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			-- TODO: Try nvim-notify instead
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		opts = {
			-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the inlay hints.
			inlay_hints = {
				enabled = true,
			},
			-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the code lenses.
			codelens = {
				enabled = false,
			},
			-- Enable lsp cursor word highlighting
			document_highlight = {
				enabled = true,
			},

			-- add any global capabilities here
			capabilities = {},
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local signs = {
				{ name = "DiagnosticSignError", text = "", priority = 100 },
				{ name = "DiagnosticSignWarn", text = "", priority = 80 },
				{ name = "DiagnosticSignHint", text = "", priority = 60 },
				{ name = "DiagnosticSignInfo", text = "", priority = 40 },
			}

			local virtual_text = {
				spacing = 2,
				source = "if_many",
				-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
				-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
				-- prefix = "icons",
				severity = vim.diagnostic.severity.ERROR,
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(
					sign.name,
					{ texthl = sign.name, text = sign.text, numhl = "", priority = sign.priority }
				)
			end

			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				virtual_text = virtual_text,
				float = {
					focusable = true,
					style = "minimal",
					border = "none",
					source = "always",
					header = "",
				},
			})

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gu", require("telescope.builtin").lsp_references, "[G]oto [U]sage")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ps",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"Works[P]ace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>re", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("<leader>ld", vim.diagnostic.open_float, "Show line diagnostics") -- show diagnostics for line

					map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic") -- jump to previous diagnostic in buffer

					map("]d", vim.diagnostic.goto_next, "Go to next diagnostic") -- jump to next diagnostic in buffer

					-- map("<leader>ri", "<cmd>TypescriptRenameFile<CR>", "[R]ename f[I]le")
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
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.removeUnusedImports.ts" },
								diagnostics = {},
							},
						})
					end, "Organize imports")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client and client.server_capabilities.documentHighlightProvider then
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

					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
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

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

			-- Setup handlers for LSP servers
			mason_lspconfig.setup_handlers({
				-- default handler for installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["ts_ls"] = function()
					lspconfig["ts_ls"].setup({
						init_options = {
							preferences = {
								importModuleSpecifierPreference = "project-relative",
								organizeImportsCollation = "ordinal",
							},
						},
						root_dir = require("lspconfig.util").root_pattern(
							".git",
							"tsconfig.base.json",
							"tsconfig.json",
							"jsconfig.json",
							"package.json"
						),
						capabilities = capabilities,
					})
				end,
				["graphql"] = function()
					-- configure graphql language server
					lspconfig["graphql"].setup({
						capabilities = capabilities,
						filetypes = {
							"graphql",
							"gql",
							"typescriptreact",
							"javascriptreact",
							"typesscript",
							"javascript",
						},
					})
				end,
				["emmet_ls"] = function()
					-- configure emmet language server
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
						},
					})
				end,
				["lua_ls"] = function()
					-- configure lua server (with special settings)
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								-- make the language server recognize "vim" global
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
				["jsonls"] = function()
					lspconfig["jsonls"].setup({
						capabilities = capabilities,
						settings = {
							json = {
								schemas = require("schemastore").json.schemas({
									-- select = {
									-- 	"Renovate",
									-- 	"GitHub Workflow Template Properties",
									-- },
								}),
								validate = { enable = true },
							},
						},
					})
				end,
			})
		end,
	},
}
