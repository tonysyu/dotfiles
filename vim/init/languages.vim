" Filetype mappings
" ......................................................................
augroup filetype_mappings
    autocmd!
    autocmd BufNewFile,BufRead,BufFilePost *.txt set filetype=markdown
    autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END

" emmet configuration
" ......................................................................
" Change leader key to something other than <C-Y>, which is used to confirm
" completion results in coc.nvim
let g:user_emmet_leader_key='<C-Z>'
