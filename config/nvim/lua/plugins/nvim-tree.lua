return {
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			-- Disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			local nvim_tree = require("nvim-tree")
			local api = require("nvim-tree.api")

			local function my_on_attach(bufnr)
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
			end

			nvim_tree.setup({
				renderer = {
					root_folder_label = false,
				},
				on_attach = my_on_attach,
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				disable_netrw = true,
				hijack_netrw = true,
				actions = {
					open_file = {
						window_picker = {
							exclude = {
								filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", "alpha" },
								buftype = { "nofile", "terminal", "help" },
							},
						},
					},
				},
				open_on_tab = false,
				hijack_cursor = false,
				update_cwd = true,
				diagnostics = {
					enable = true,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
				update_focused_file = {
					enable = true,
					update_cwd = true,
					update_root = true,
					ignore_list = {},
				},
				system_open = {
					cmd = nil,
					args = {},
				},
				filters = {
					dotfiles = false,
					custom = {},
				},
				git = {
					enable = false,
				},
				view = {
					width = 50,
					side = "left",
					-- mappings = {
					-- 	custom_only = false,
					-- 	list = {
					-- 		{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
					-- 		{ key = "h", cb = tree_cb("close_node") },
					-- 		{ key = "v", cb = tree_cb("vsplit") },
					-- 	},
					-- },
					number = false,
					relativenumber = false,
				},
				trash = {
					cmd = "trash",
					require_confirm = true,
				},
				filesystem_watchers = {
					enable = true,
					debounce_delay = 50,
					ignore_dirs = { "node_modules" },
				},
			})

			api.events.subscribe(api.events.Event.FileCreated, function(file)
				vim.cmd("edit " .. file.fname)
			end)

			vim.keymap.set("n", "<leader>v", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
		end,
	},
}
