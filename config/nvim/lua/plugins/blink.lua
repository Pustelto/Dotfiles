---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
			-- Keymaps:
			--   <C-j>/<C-k>     navigate menu (next/prev)
			--   <Tab>           accept menu item; if in a snippet, jump to next placeholder
			--   <S-Tab>         jump back in a snippet
			--   <CR>            plain newline (menu doesn't intercept it)
			--   <Esc>           close menu first, then exit insert on second press
			--   <C-Space>       open menu / cycle docs
			--   <C-e>           cancel (alternate)
			--   <C-u>/<C-d>     scroll docs
			keymap = {
				preset = "none",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<Esc>"] = { "hide", "fallback" },
				["<CR>"] = { "fallback" },

				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },

				["<Tab>"] = { "accept", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

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
