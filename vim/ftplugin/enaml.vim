
" Save script, run script in it's directory, and return to working directory
function! RunEnaml()
    write
    let current = getcwd()
    cd %:p:h
    !enaml-run %
    cd `=current`
endfunction
nnoremap <buffer> <silent> <leader>r :call RunEnaml()<CR>


