-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

local numWidth = 5

local options = {
	-- set term gui colors (most terminals support this)
	-- termguicolors = true,

	encoding = "utf-8", -- set encoding used internaly
	fileencoding = "utf-8", -- the encoding written to a file

	number = true, -- show line numbers
	relativenumber = true, -- set relative numbered lines (for better navigation)
	numberwidth = numWidth, -- Width of column with line numbers

	-- Enable mouse mode, can be useful for resizing splits for example!
	mouse = "a",

	-- Don't show the mode, since it's already in the status line
	showmode = false,
	-- Enable break indent
	breakindent = true,
	linebreak = true,

	-- Sync clipboard between OS and Neovim.
	--  Remove this option if you want your OS clipboard to remain independent.
	--  See `:help 'clipboard'`
	clipboard = "unnamedplus",
	-- highlight the current line
	cursorline = true,

	-- always show the sign column, otherwise it would shift the text each time
	signcolumn = "yes",

	-- Save undo history
	undofile = true,
	-- Create a backup file
	backup = false,
	-- Disable swap file
	swapfile = false,

	-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
	ignorecase = true,
	smartcase = true,
	-- highlight all matches on previous search pattern
	hlsearch = true,
	incsearch = true,
	-- Preview substitutions live, as you type!
	inccommand = "split",
	-- TODO: what this does?
	showmatch = true,

	-- Decrease mapped sequence wait time - how long will nvim wait for a mapped sequence to complete
	-- eg. how long it will wait for another key after <leader> is pressed.
	-- Displays which-key popup sooner
	timeoutlen = 300,

	-- Minimal number of screen lines to keep above and below the cursor.
	scrolloff = 8,
	updatetime = 300,

	--show file name and path at the top of buffer together with modify mark,
	-- spaces at the front are here to align it with the gutter
	-- we have to still append extra 2 spaces to count in signcolumn
	-- winbar = string.rep(" ", numWidth) .. "  %f %m",

	shiftwidth = 2, -- the number of spaces inserted for (auto)indent step
	tabstop = 2, -- insert 2 spaces for a tab
	expandtab = true, -- use spaces when <Tab> is inserted
	-- TODO: DO I need this?
	-- smartindent = true, -- smart autoindenting for C programs
	smarttab = true, -- use 'shiftwidth' when inserting <Tab>

	ruler = true, -- show the cursor position (line and char) in the status bar

	-- splitbelow = false, -- force all horizontal splits to go below current window
	-- splitright = false, -- force all vertical splits to go to the right of current window

	formatoptions = {
		t = true,
		c = true,
		r = true,
		o = true,
		q = true,
		n = true,
		l = true,
		j = true,
	},
	diffopt = {
		"internal",
		"filler",
		"closeoff",
		"indent-heuristic",
		"algorithm:patience",
		"linematch:160",
		"context:10",
	}
}

vim.opt.matchpairs:append("<:>")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Folding
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldtext = ""
-- don't like the look of fold column, ideally add it as a sign or find a way how to show just closed folds (or indicator for possible folds)
-- vim.opt.fillchars:append({ fold = " ", foldopen = "", foldclose = "" })
vim.opt.fillchars:append({ fold = " " })
-- Default to treesitter folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

-- TODO: DO I NEED THIS?
-- vim.cmd("filetype plugin on")

-- TODO: DO I NEED THIS?
-- vim.cmd("syntax enable")

-- In git commitmessage force cursor onto a new line after 72 chars
-- Color 73rd column in order to know where is the type limit
-- Also color 51st column
-- vim.cmd([[
-- 	autocmd FileType gitcommit set textwidth=72
-- 	set colorcolumn=+1
-- 	autocmd FileType gitcommit set colorcolumn+=51
-- ]])

-- TODO: DO I NEED THIS?
-- Disable netrw (becuase of NvimTree)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
