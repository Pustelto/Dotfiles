" Use the space key as our leader. Put this near the top of your vimrc
let mapleader = "\<Space>"

" Rapid Editing of Your Vimrc
nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

imap jk <esc>
imap kj <esc>
imap jj <esc>

set nocompatible

filetype plugin on
syntax enable
set showmatch
set t_Co=256
" In git commitmessage force cursor onto a new line after 72 chars
autocmd FileType gitcommit set textwidth=72
" Color 73rd column in order to know where is the type limit
set colorcolumn=+1
" Also color 51st column
autocmd FileType gitcommit set colorcolumn+=51
set statusline=%f\ %=Line\ %l/%L\ Col\ %c\ (%p%%)set statusline=%f\ %=Line\ %l/%L\ Col\ %c\ (%p%%)
set autoindent                  " Copy indent from current line on <CR>
set backspace=indent,eol,start  " Backspace behaviour
set encoding=utf-8              " Set character encoding
set expandtab                   " Expand tabs to spaces
set hlsearch                    " Highlight all search results
set ignorecase                  " Ignore case when searching
set incsearch                   " Show matches when searching
set linebreak                   " Break lines at word
set number                      " Show line number
set relativenumber
set nuw=7
set foldcolumn=0
set shiftwidth=2                " Number of spaces to use for indent
set showbreak=+++               " Broken line prefix
set smartcase                   " Enable smart-case search
set smartindent                 " Enable smart-indent
set smarttab                    " Enable smart-tab
set softtabstop=2               " Number of spaces per Tab
set ruler                       " Show line and column number
set textwidth=100               " Line wrap
set undolevels=1000             " Number of undo levels
set visualbell                  " Use visual bell (silence system bell)
