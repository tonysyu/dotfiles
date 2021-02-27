" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
" Toggle QuickFix pane (vt = "view quickfix")
nnoremap <leader>vq <cmd>QFix<CR>

" CHADtree
" ......................................................................
" Toggle Chadtree pane (vt = "view tree")
nnoremap <leader>vt <cmd>CHADopen<cr>

" Vista
" ......................................................................
let g:vista_default_executive = 'coc'
"" Toggle Vista pane (vt = "view symbols")
nnoremap <leader>vs <cmd>Vista!!<cr>

" vim-indent-guides Settings
" ......................................................................

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 4

augroup indent_guides_config
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#202020 ctermbg=234
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030 ctermbg=236
augroup END


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
