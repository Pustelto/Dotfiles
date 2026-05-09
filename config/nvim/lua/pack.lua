-- Native plugin manager. Replaces lazy.nvim. See `:help vim.pack`.
-- Each plugin's setup lives in lua/plugins/<name>.lua and is required after
-- vim.pack.add() finishes installing/loading the runtime files.

local function gh(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	-- Library
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("folke/lazydev.nvim") },

	-- Colorscheme (loaded eagerly so it applies before UI is drawn)
	{ src = gh("folke/tokyonight.nvim") },

	-- Editing
	{ src = gh("tpope/vim-surround") },
	{ src = gh("tpope/vim-repeat") },
	{ src = gh("windwp/nvim-autopairs") },
	{ src = gh("windwp/nvim-ts-autotag") },
	{ src = gh("Konfekt/vim-CtrlXA") },
	{ src = gh("numToStr/Comment.nvim") },
	{ src = gh("JoosepAlviste/nvim-ts-context-commentstring") },
	{ src = gh("folke/todo-comments.nvim") },

	-- UI
	{ src = gh("folke/which-key.nvim") },
	{ src = gh("nvim-tree/nvim-web-devicons") },
	{ src = gh("nvim-tree/nvim-tree.lua") },
	{ src = gh("stevearc/oil.nvim") },
	{ src = gh("norcalli/nvim-colorizer.lua") },
	{ src = gh("folke/snacks.nvim") },
	{ src = gh("nvim-lualine/lualine.nvim") },
	{ src = gh("AndreM222/copilot-lualine") },

	-- Treesitter (main branch)
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
	{ src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
	{ src = gh("nvim-treesitter/nvim-treesitter-context") },

	-- Git
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("kdheepak/lazygit.nvim") },
	{ src = gh("sindrets/diffview.nvim") },

	-- LSP / tools
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("mason-org/mason-lspconfig.nvim") },
	{ src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
	{ src = gh("b0o/schemastore.nvim") },
	{ src = gh("dmmulroy/ts-error-translator.nvim") },

	-- Lint / format
	{ src = gh("mfussenegger/nvim-lint") },
	{ src = gh("stevearc/conform.nvim") },

	-- Completion
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
	{ src = gh("rafamadriz/friendly-snippets") },

	-- AI
	{ src = gh("github/copilot.vim") },
}, { confirm = false })

-- Plugin setup. Order matters where dependencies are concrete:
--   colorscheme — first so the rest of the UI inherits the right palette
--   lazydev / which-key — independent
--   treesitter — installs parsers via build hook below
--   mason → mason-lspconfig → lsp — LSP servers need binaries on PATH

require("plugins.colorscheme")
require("plugins.lazydev")
require("plugins.surround_repeat") -- vim-surround / vim-repeat (no setup; placeholder)
require("plugins.autopairs")
require("plugins.ts_autotag")
require("plugins.ctrlxa")
require("plugins.comments")
require("plugins.todo-comments")

require("plugins.which-key")
require("plugins.web-devicons")
require("plugins.nvim-tree")
require("plugins.oil")
require("plugins.colorizer")
require("plugins.snacks")
require("plugins.lualine")

require("plugins.treesitter")

require("plugins.gitsigns")
require("plugins.lazygit")
require("plugins.diffview")

require("plugins.mason")
require("plugins.lsp")
require("plugins.ts-error-translator")

require("plugins.linting")
require("plugins.formatting")

require("plugins.blink")

require("plugins.copilot")

-- Treesitter parser install hook: re-run on plugin update.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-build", { clear = true }),
	callback = function(ev)
		local data = ev.data
		if data and data.spec and data.spec.name == "nvim-treesitter" and data.kind ~= "delete" then
			local ok, ts = pcall(require, "nvim-treesitter")
			if ok and ts.update then
				ts.update():wait(60000)
			end
		end
	end,
})
