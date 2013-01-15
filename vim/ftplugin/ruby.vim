" Save script, run script in it's directory, and return to working directory
function! RunRuby()
    write
    let current = getcwd()
    cd %:p:h
    !ruby %
    cd `=current`
endfunction
nnoremap <silent> <leader>r :call RunRuby()<CR>


