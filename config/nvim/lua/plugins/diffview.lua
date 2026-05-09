-- diffview.nvim is loaded eagerly by vim.pack; setup is implicit.
-- Keymaps are defined here (previously inline in lazy-plugins.lua).
local map = vim.keymap.set
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<leader>gD", "<cmd>DiffviewOpen<CR>", { desc = "Diff files" })
map("n", "<leader>gd", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>", { desc = "Diff branch against main" })
map(
	"n",
	"<leader>gi",
	"<cmd>DiffviewOpen @{-1}...HEAD --imply-local<CR>",
	{ desc = "Diff branch against prev stack branch" }
)
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" })
