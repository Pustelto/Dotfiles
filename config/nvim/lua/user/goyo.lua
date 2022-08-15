vim.g.goyo_width = 120
vim.g.goyo_height = "95%"
vim.g.goyo_linenr = 0

vim.api.nvim_set_keymap("n", "<leader>i", ":Goyo<CR>", { noremap = true, silent = true })

-- local function goyo_enter()
-- 	vim.opt.status = true
-- end
--
-- local function goyo_leave()
-- 	vim.opt.status = true
-- end
--
-- vim.cmd "User GoyoEnter nested call <SID>goyo_enter()"
-- autocmd! autocmd! User GoyoLeave nested call <SID>goyo_leave()
