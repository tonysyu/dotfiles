command! CdHere :cd %:p:h

" Custom functions
" ......................................................................

" Run a given vim command on the results of alt from a given path.
" See usage below.
command! -nargs=* AltFile call AltFile(expand('%'), ':e')
function! AltFile(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction
