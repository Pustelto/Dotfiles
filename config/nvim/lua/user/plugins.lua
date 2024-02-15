local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Plugins manager
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- Useful stuff (mostly consume by other plugins)
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("lewis6991/impatient.nvim")

	-- Utility plugins
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("windwp/nvim-autopairs")
	use("RRethy/vim-illuminate") -- LSP backed highlighting of symbols under cursor
	use("kyazdani42/nvim-web-devicons") -- devicons

	-- Better comments
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				signs = false,
				colors = {
					error = { "#F7454B" },
					warning = { "#ffcb6b" },
					info = { "#89ddff" },
				},
				highlight = {
					keyword = "bg",
					after = "fg", -- "fg" or "bg" or empty
				},
			})
		end,
	})

	use("github/copilot.vim")

	use("kyazdani42/nvim-tree.lua")
	use("nvim-lualine/lualine.nvim")
	use("ahmedkhalf/project.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("echasnovski/mini.indentscope")
	use("mattn/emmet-vim")
	use("Konfekt/vim-CtrlXA")
	--  use "goolord/alpha-nvim"
	use("folke/which-key.nvim")
	use("norcalli/nvim-colorizer.lua")

	-- Colorschemes
	-- use("kaicataldo/material.vim")
	-- use("hzchirs/vim-material")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("user.snippets")
		end,
	})

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("jose-elias-alvarez/typescript.nvim")
	use({ "j-hui/fidget.nvim", tag = "legacy" }) -- UI for status of LSP server

	-- Rust
	use("rust-lang/rust.vim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")

	-- Testings
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Test adapters
			"guivazcabral/neotest-jest",
		},
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
