function! s:NormalizeNames(names) abort
  if type(a:names) isnot# v:t_list
    return []
  endif
  let l:out = []
  let l:last = ''
  for l:name in a:names
    if type(l:name) isnot# v:t_string
      continue
    endif
    if l:name ==# ''
      continue
    endif
    if l:name ==# l:last
      continue
    endif
    call add(l:out, l:name)
    let l:last = l:name
  endfor
  return l:out
endfunction

function! inspect#Inspect(verbose) abort
  if !exists('*synstack') || !exists('*synIDattr') || !exists('*synIDtrans') || !exists('*synID')
    echohl WarningMsg | echo 'vim-inspect: syntax inspection is not available in this vim' | echohl None
    return
  endif
  let l:lnum = line('.')
  let l:ccol = col('.')
  if l:lnum < 1 || l:ccol < 1
    echohl WarningMsg | echo 'vim-inspect: invalid cursor position' | echohl None
    return
  endif
  let l:stack = synstack(l:lnum, l:ccol)
  let l:syntax_names = s:NormalizeNames(map(copy(l:stack), 'synIDattr(v:val, "name")'))
  let l:resolved_names = s:NormalizeNames(map(copy(l:stack), 'synIDattr(synIDtrans(v:val), "name")'))
  let l:effective_id = synID(l:lnum, l:ccol, 1)
  let l:effective_name = l:effective_id > 0 ? synIDattr(l:effective_id, 'name') : ''
  if empty(l:syntax_names) && empty(l:resolved_names) && l:effective_name ==# ''
    echohl WarningMsg | echo 'vim-inspect: no highlight group under cursor' | echohl None
    return
  endif
  if !a:verbose
    if !empty(l:resolved_names)
      echo join(l:resolved_names, ' > ')
      return
    endif
    if !empty(l:syntax_names)
      echo join(l:syntax_names, ' > ')
      return
    endif
    echo l:effective_name
    return
  endif
  let l:syntax_line = 'Syntax:   ' . (empty(l:syntax_names) ? '<none>' : join(l:syntax_names, ' > '))
  let l:resolved_line = 'Resolved: ' . (empty(l:resolved_names) ? '<none>' : join(l:resolved_names, ' > '))
  let l:effective_line = 'Effective:' . (l:effective_name ==# '' ? ' <none>' : ' ' . l:effective_name)
  echom l:syntax_line
  echom l:resolved_line
  echom l:effective_line
endfunction
