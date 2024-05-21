-- Remap tab to Ctrl-N for accepting Copilot suggestions
vim.keymap.set("i", "<C-n>", 'copilot#Accept("<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
vim.g.copilot_workspace_folders = { "~/Ataccama/one-metadata-frontend" }
-- disable copilot by default
-- vim.g.copilot_filetypes = { ["*"] = false }

-- Map Alt-O to request Copilot completions
vim.keymap.set("i", "<M-e>", "<Plug>(copilot-dismiss)")
vim.keymap.set("i", "<M-o>", "<Plug>(copilot-suggest)")
vim.keymap.set("i", "<M-i>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<M-u>", "<Plug>(copilot-previous)")
vim.keymap.set("i", "<M-Right>", "<Plug>(copilot-accept-word)")
vim.keymap.set("i", "<M-Down>", "<Plug>(copilot-accept-line)")
