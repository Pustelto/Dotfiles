filetype plugin on
syntax enable
set showmatch
set t_Co=256
set textwidth=80
" In git commit message force cursor onto a new line after 72 chars
autocmd FileType gitcommit set textwidth=72
" Color 73rd column in order to know where is the type limit
set colorcolumn=+1
" Also color 51st column
autocmd FileType gitcommit set colorcolumn+=51
set statusline=%f\ %=Line\ %l/%L\ Col\ %c\ (%p%%)set statusline=%f\ %=Line\ %l/%L\ Col\ %c\ (%p%%)
