if exists('g:loaded_inspect') || has('nvim') || v:version < 700 || &compatible
  finish
endif
let g:loaded_inspect = 1

command! -bang Inspect call inspect#Inspect(<bang>0)
