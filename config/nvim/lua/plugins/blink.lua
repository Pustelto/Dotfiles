---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
			-- Preserve current keymap UX from nvim-cmp:
			--   <C-k>/<C-j>     prev/next item
			--   <C-Space>       trigger / show docs
			--   <CR>            confirm (no auto-select unless visible)
			--   <Tab>/<S-Tab>   cycle items, then jump snippet placeholders
			--   <C-u>/<C-d>     scroll docs
			--   <C-e>           cancel
			keymap = {
				preset = "none",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<Tab>"] = {
					"select_next",
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					"select_prev",
					"snippet_backward",
					"fallback",
				},

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				accept = { auto_brackets = { enabled = true } },
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name" },
						},
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = false },
			},

			signature = { enabled = true },

			snippets = { preset = "default" }, -- vim.snippet

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					snippets = {
						opts = {
							search_paths = {
								vim.fn.stdpath("config") .. "/snippets",
							},
						},
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
})
