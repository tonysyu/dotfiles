" Change j and k to move by screen line instead of file line (wrapped lines)
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^
vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^

" Navigate buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" search and replace
nnoremap <leader>ss :%s/
vnoremap <leader>ss :s/

" case insensitive incsearch
nnoremap c/ /\c

" incsearch.vim settings
" ......................................................................
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" https://vi.stackexchange.com/a/8742
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" vim-fzf
" ......................................................................
nnoremap <leader>t :GitFiles<cr>
nnoremap <leader>b :Buffers<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})


" Case-insensitive ripgrep search
command! -bang -nargs=* Rgi
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --ignore-case ".shellescape(<q-args>),
    \                   1, <bang>0)

" Ripgrep search for word-under cursor
nnoremap <silent> <leader>// :Rg <c-r><c-w><cr>
" Ripgrep search for visual selection
vnoremap <silent> <leader>// y:Rg <c-r>"<cr>
" Ripgrep search for word-under cursor, surrounded by word boundaries
nnoremap <silent> <leader>/w :Rg \b<c-r><c-w>\b<cr>
" Ripgrep search for word-under cursor, surrounded by word boundaries
vnoremap <silent> <leader>/w y:Rg \b<c-r>"\b<cr>
" Ripgrep search for word-under cursor
nnoremap <silent> <leader>/i :Rgi <c-r><c-w><cr>
" Ripgrep search for visual selection
vnoremap <silent> <leader>/i y:Rgi <c-r>"<cr>

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
