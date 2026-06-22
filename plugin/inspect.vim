if exists('g:loaded_inspect') || has('nvim') || v:version < 800 || &compatible
  finish
endif
let g:loaded_inspect = 1

command! -bang Inspect call inspect#Inspect(<bang>0)
