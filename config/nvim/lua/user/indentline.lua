local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
	return
end

indent_blankline.setup({
	exclude = {
		filetypes = {
			"lspinfo",
			"packer",
			"checkhealth",
			"help",
			"man",
			"gitcommit",
			"TelescopePrompt",
			"TelescopeResults",
			"",
			"NvimTree",
		},
	},
	indent = {
		char = "▏",
	},
})

local indentscope_ok, indentscope = pcall(require, "mini.indentscope")
if not indentscope_ok then
	return
end

indentscope.setup({
	draw = {
		animation = indentscope.gen_animation.none(),
	},
	symbol = "▏",
})

-- How to disable mini.indentscope for some buffer types
-- https://github.com/echasnovski/mini.nvim/blob/75477368c63e3dee65b2a39e6050391ef521f0b8/doc/mini.txt#L143-L184
-- Disable mini.indentscope for some buffer types
vim.cmd([[
  autocmd Filetype NvimTree lua vim.b.minicursorword_disable = true
  autocmd Filetype help lua vim.b.minicursorword_disable = true
  autocmd Filetype lspinfo lua vim.b.minicursorword_disable = true
  autocmd Filetype packer lua vim.b.minicursorword_disable = true
  autocmd Filetype checkhealth lua vim.b.minicursorword_disable = true
  autocmd Filetype TelescopePrompt lua vim.b.minicursorword_disable = true
  autocmd Filetype TelescopeResults lua vim.b.minicursorword_disable = true
]])
