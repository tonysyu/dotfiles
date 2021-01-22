" reflow paragraph (i.e. remove end of lines)
nnoremap Q gqap
" reflow selected text
vnoremap Q gq

" vim line-object from https://vi.stackexchange.com/a/6102/12878
xnoremap il g_o0
onoremap il :normal! vil<CR>
xnoremap al $o0
onoremap al :normal! val<CR>

" vim-closetag
" ......................................................................
let g:closetag_filenames = "*.html,*.js"

" vim-schlepp
" ......................................................................
vmap <up> <Plug>SchleppUp
vmap <down> <Plug>SchleppDown
vmap <left> <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight
vmap D <Plug>SchleppDup
let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlocks = 1

" vim-surround
" ......................................................................
let g:surround_{char2nr('w')} = "{{\r}}"
let g:surround_{char2nr('%')} = "{%\r%}"


" UltiSnips
" ......................................................................
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

" Custom stab (set tabwidth) command for setting tabwidth + shiftwidth + tabstop
" ......................................................................
" from http://stackoverflow.com/questions/1562336/tab-vs-space-preferences-in-vim
" http://vimcasts.org/episodes/tabs-and-spaces/ is also worth checking out
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set shiftwidth=')

  if l:tabstop > 0
    " do we want expandtab as well?
    let l:expandtab = confirm('set expandtab?', "&Yes\n&No\n&Cancel")
    if l:expandtab == 3
      " abort?
      return
    endif

    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop

    if l:expandtab == 1
      setlocal expandtab
    else
      setlocal noexpandtab
    endif
  endif

  " show the selected options
  try
    echohl ModeMsg
    echon 'set tabstop='
    echohl Question
    echon &l:ts
    echohl ModeMsg
    echon ' shiftwidth='
    echohl Question
    echon &l:sw
    echohl ModeMsg
    echon ' sts='
    echohl Question
    echon &l:sts . ' ' . (&l:et ? '  ' : 'no')
    echohl ModeMsg
    echon 'expandtab'
  finally
    echohl None
  endtry
endfunction
