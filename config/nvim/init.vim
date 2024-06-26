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

-- Github Copilot
require "user.copilot"

-- Utility plugins
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.telescope"
require "user.project"
require "user.nvim-tree"
require "user.lualine"
require "user.impatient"
require "user.indentline"
require "user.emmet"
require "user.ctrlxa"
require "user.colorizer"
-- require "user.alpha"
require "user.whichkey"
-- require "user.autocommands"
require "user.dap"
require "user.neotest"
require "user.doge"
EOF
