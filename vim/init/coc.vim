" Common extensions
let g:coc_global_extensions = [
    \'coc-css',
    \'coc-highlight',
    \'coc-json',
    \'coc-prettier',
    \'coc-pyright',
    \'coc-tabnine',
    \'coc-tsserver',
    \'coc-yaml'
    \]

" coc-highlight: Highlight current word under cursor
autocmd CursorMoved * silent call CocActionAsync('highlight')
highlight CocHighlightText ctermfg=LightMagenta ctermfg=Black guifg=#ff00ff guibg=#000000

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
