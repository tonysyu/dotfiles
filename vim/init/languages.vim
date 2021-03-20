" Filetype mappings
" ......................................................................
augroup filetype_mappings
    autocmd!
    autocmd BufNewFile,BufRead,BufFilePost *.txt set filetype=markdown
    autocmd BufNewFile,BufRead,BufFilePost *.tex set filetype=tex
    autocmd BufNewFile,BufRead,BufFilePost *.cls set filetype=tex
    autocmd BufNewFile,BufRead,BufFilePost *.css_t set filetype=css
    autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType python let b:coc_root_patterns = ['manage.py', '.git', '.env']
augroup END

" Python
" ......................................................................
" syntax/python.vim gets run before ftplugin/python.vim, so we must set this
" highlight option in vimrc instead of ftplugin.
let g:python_highlight_all = 0

" SimpylFold
" ......................................................................
let g:SimpylFold_docstring_preview = 1

" vim-jsx
" ......................................................................
let g:jsx_ext_required = 0  " Use vim-jsx for all .js files

" riv plugin configuration
" ......................................................................
" Avoid maxmempattern error in riv
" See https://github.com/gu-fan/riv.vim/issues/144#issuecomment-537056690
set mmp=2000

" emmet configuration
" ......................................................................
" Change leader key to something other than <C-Y>, which is used to confirm
" completion results in coc.nvim
let g:user_emmet_leader_key='<C-Z>'
