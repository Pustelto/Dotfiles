vim.g.copilot_no_tab_map = true
vim.g.copilot_workspace_folders = { "~/Ataccama/one-metadata-frontend" }

local map = vim.keymap.set
map("i", "<C-n>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
map("i", "<M-e>", "<Plug>(copilot-dismiss)")
map("i", "<M-o>", "<Plug>(copilot-suggest)")
map("i", "<M-i>", "<Plug>(copilot-next)")
map("i", "<M-u>", "<Plug>(copilot-previous)")
map("i", "<M-Right>", "<Plug>(copilot-accept-word)")
map("i", "<M-Down>", "<Plug>(copilot-accept-line)")
