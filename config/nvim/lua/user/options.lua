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
  nuw = 7,
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartindent = true,
  smartcase = true,
  smarttab = true,
  ruler = true,
  re = 0,
  undofile = true,
  textwidth = 100,
  colorcolumn = "+1",
  cursorline = true, -- highlight the current line
  -- splitbelow = false, -- force all horizontal splits to go below current window
  -- splitright = false, -- force all vertical splits to go to the right of current window
  expandtab = true, -- convert tabs to spaces
  scrolloff = 8, -- is one of my fav
  -- Options in test:
  updatetime = 300, -- faster completion (4000ms default)
  swapfile = false,
  winbar = "         %f %m", --show file name and path at the top of buffer together with modify mark, spaces at the front are here to align it with the gutter
  --[[ showtabline = 2, -- always show tabs ]]
}

-- vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.formatoptions:append("tcroj")

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
-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
