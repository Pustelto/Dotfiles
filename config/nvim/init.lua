--[[
    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

require("autocommands")

require("custom-commands")

-- [[ Opt in to the new message/cmdline UI (Neovim 0.12) ]]
pcall(function()
	require("vim._core.ui2").enable({})
end)

-- [[ Native plugin manager: vim.pack + per-plugin setup ]]
require("pack")

-- [[ Enable LSP servers — configs come from lsp/<name>.lua and nvim-lspconfig defaults ]]
vim.lsp.enable({
	"ts_ls",
	"html",
	"cssls",
	"tailwindcss",
	"lua_ls",
	"graphql",
	"emmet_ls",
	"prismals",
	"pyright",
	"rust_analyzer",
	"dockerls",
	"yamlls",
	"bashls",
	"vimls",
	"jsonls",
})
