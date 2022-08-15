vim.cmd([[
try
  " colorscheme material
  colorscheme my-material
  " colorscheme moonrakers
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
