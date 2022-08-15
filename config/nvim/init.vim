scriptencoding utf-8

" Config taken from https://github.com/LunarVim/Neovim-from-scratch
lua << EOF
-- Basics
require "user.options"
require "user.colorscheme"
require "user.keymaps"
require "user.plugins"
require "user.treesitter"

-- Autocompletions
require "user.cmp"

-- Language server
require "user.lsp"

-- Utility plugins
require "user.goyo"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.telescope"
require "user.project"
require "user.nvim-tree"
require "user.lualine"
-- require "user.toggleterm"
require "user.impatient"
require "user.indentline"
-- require "user.alpha"
-- require "user.whichkey"
-- require "user.autocommands"
EOF
