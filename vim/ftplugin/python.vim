"
" Auto completion via ctrl-shift-n (instead of ctrl-x ctrl-o)
set omnifunc=pythoncomplete#Complete
inoremap <C-b> <C-x><C-o>
" blocks are denoted by indent
set foldmethod=indent
set foldlevel=99
" pyflakes quickfix window will override other quickfix windows
let g:pyflakes_use_quickfix = 0

" Save script, run script in it's directory, and return to working directory
function! RunPython()
    write
    let current = getcwd()
    cd %:p:h
    !python %
    cd `=current`
endfunction
nnoremap <silent> <leader>r :call RunPython()<CR>
let g:python_highlight_all = 1
