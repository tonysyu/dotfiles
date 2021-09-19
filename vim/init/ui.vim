" lightline.vim
" ......................................................................
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" vim-buftabline
" ......................................................................
nnoremap <D-M-k> :bn<CR>
nnoremap <D-M-j> :bp<CR>
let g:buftabline_numbers = 1
let g:buftabline_separators = 1

" Use vertical splits for Gdiff (this affects all diffs, not just fugitive's)
set diffopt+=vertical
