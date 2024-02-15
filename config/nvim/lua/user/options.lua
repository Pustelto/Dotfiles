local options = {
	termguicolors = true, -- set term gui colors (most terminals support this)
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	encoding = "utf-8",
	fileencoding = "utf-8", -- the encoding written to a file
	inccommand = "split",
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	showmatch = true,
	hlsearch = true, -- highlight all matches on previous search pattern
	incsearch = true,
	ignorecase = true, -- ignore case in search patterns
	numberwidth = 7,
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartindent = true,
	smartcase = true,
	smarttab = true,
	ruler = true,
	re = 0, -- regexp engine, 0 - standard VIM, 1 - PCRE (Perl)
	undofile = true,
	textwidth = 120,
	-- columns = 100,
	colorcolumn = "+1",
	-- wrap = true,
	-- colorcolumn = "",
	linebreak = true,
	cursorline = true, -- highlight the current line
	-- splitbelow = false, -- force all horizontal splits to go below current window
	-- splitright = false, -- force all vertical splits to go to the right of current window
	expandtab = true, -- convert tabs to spaces
	scrolloff = 8, -- is one of my fav
	updatetime = 500, -- faster completion (4000ms default)
	swapfile = false,
	winbar = "         %f %m", --show file name and path at the top of buffer together with modify mark, spaces at the front are here to align it with the gutter
	mouse = "a", -- enable mouse support
	foldmethod = "syntax", -- config for automatic folds
	foldlevelstart = 99, -- start with all folds open
	foldcolumn = "auto", -- show fold column
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.formatoptions = {
	t = true,
	c = true,
	r = true,
	o = true,
	q = true,
	n = true,
	l = true,
	j = true,
}

vim.cmd("filetype plugin on")
vim.cmd("syntax enable")
-- In git commitmessage force cursor onto a new line after 72 chars
-- Color 73rd column in order to know where is the type limit
-- Also color 51st column
vim.cmd([[
	autocmd FileType gitcommit set textwidth=72
	set colorcolumn=+1
	autocmd FileType gitcommit set colorcolumn+=51
]])

-- Disable netrw (becuase of NvimTree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
