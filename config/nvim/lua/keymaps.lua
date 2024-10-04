-- Clear search highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>hl", "<cmd>nohlsearch<CR>")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- [[ Normal mode mappings ]]
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
--
-- Resize window using <ctrl> arrow keys
-- TODO: change to different key, I don't have arrows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Paste without overwritting register
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("v", "p", '"_dP')
-- Delete without overwritting register
vim.keymap.set("v", "<leader>d", '"_d')

-- Better buffers navigation:
-- Close buffer without closing split
vim.keymap.set("n", "<C-c>", "<cmd>bp|bd #<CR>")
vim.keymap.set("n", "<leader><leader>", "<cmd>b#<CR>")
-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- [[ Insert mode mapping ]]
-- Press jk fast to enter
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "jj", "<ESC>")
