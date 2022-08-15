local options = {
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  encoding = "utf-8",
  fileencoding = "utf-8",                  -- the encoding written to a file
  inccommand = "split",
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  showmatch = true,
  hlsearch = true,                         -- highlight all matches on previous search pattern
  incsearch = true,
  nuw = 7,
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartindent = true,
  smartcase = true,
  smarttab = true,
  ruler = true,
  undofile = true,
	textwidth = 100,




--
 -- cmdheight = 2,                           -- more space in the neovim command line for displaying messages
 -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
 -- conceallevel = 0,                        -- so that `` is visible in markdown files
 -- ignorecase = true,                       -- ignore case in search patterns
 -- mouse = "a",                             -- allow the mouse to be used in neovim
 -- pumheight = 10,                          -- pop up menu height
 -- showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
 -- showtabline = 2,                         -- always show tabs
 -- splitbelow = true,                       -- force all horizontal splits to go below current window
 -- splitright = true,                       -- force all vertical splits to go to the right of current window
 -- updatetime = 300,                        -- faster completion (4000ms default)
 -- writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
 -- expandtab = true,                        -- convert tabs to spaces
 cursorline = true,                       -- highlight the current line
 -- numberwidth = 4,                         -- set number column width to 2 {default 4}
 -- wrap = false,                            -- display lines as one long line
 -- scrolloff = 8,                           -- is one of my fav
 -- sidescrolloff = 8,
 -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

-- vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "filetype plugin on"
vim.cmd "syntax enable"
-- In git commitmessage force cursor onto a new line after 72 chars
-- Color 73rd column in order to know where is the type limit
-- Also color 51st column
vim.cmd [[
	autocmd FileType gitcommit set textwidth=72
	set colorcolumn=+1
	autocmd FileType gitcommit set colorcolumn+=51
]]
-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
