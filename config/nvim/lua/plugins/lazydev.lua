-- Lua dev hints (lazy on lua filetype).
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("lazydev-lua", { clear = true }),
	pattern = "lua",
	once = true,
	callback = function()
		require("lazydev").setup({
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				plugins = { "nvim-treesitter", "plenary.nvim" },
			},
		})
	end,
})
