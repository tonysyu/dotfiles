"remove vi compatibility (this should be first since it has side effects)
set nocompatible
" syntax highlighting on

" Set vim to use colorschemes with 256 colors
set t_Co=256
set background=dark
colorscheme molokai
" Fix terminal colors in vimr (https://github.com/qvacua/vimr/issues/719)
set termguicolors

syntax on

source ~/.config/nvim/init/bundles.vim

set modelines=0                 " don't add configuration lines to files

" change the mapleader from \ to ,
let mapleader=","
let maplocalleader=","
" let semicolon start EX-mode (a.k.a. command mode)
"nnoremap ; :
set showmode                    " display mode in Insert, Replace or Visual
set cursorline                  " highlight current line
set wildmode=longest,list,full  " change tab-completion to be more like BASH

" Whitespace
" set list                      " show whitespace (negates linebreak)
set tabstop=4                   " tab is 4 spaces
set shiftwidth=4                " indentation in normal mode is 4 spaces
set softtabstop=4               " back space removes up-to 4 spaces
set expandtab                   " expand tabs to spaces

" Search
set wildignorecase              " Ignore case in file searches (e.g. in ex mode)

" line width and indenting
set wrap
set linebreak                   " set list and set linebreak conflict!
set textwidth=99
set formatoptions=qrn1

set number                  	" show line numbers
set relativenumber          	" number lines relative to current line
set colorcolumn=100         	" add line marking column
set undofile                	" allow undo across file sessions
set undodir=~/.config/nvim/undo/
set tags+=.tags;~              " The trailing ';~' tells vim to search parent directories upto ~.

" Search customization
" ====================
set gdefault                    " make substitutions global by default

" Filetype mappings
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

augroup autosave
    autocmd!
    autocmd BufLeave,FocusLost silent! wall " save when focus is lost
augroup END
" Since I'm auto-saving (above), don't save backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" Allow switching from modified buffers (i.e. hidden buffers)
set hidden
" Confirm before quitting if a modified buffer is hidden
set confirm

" Change j and k to move by screen line instead of file line (wrapped lines)
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^
vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^

" vim line-object from https://vi.stackexchange.com/a/6102/12878
xnoremap il g_o0
onoremap il :normal! vil<CR>
xnoremap al $o0
onoremap al :normal! val<CR>

" Navigate buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ctrl-/ to start case-insensitive search
nnoremap <C-/> :/\c

" Disable most-recent buffer toggle to avoid conflicts with easymotion
" Toggle between two, most-recent buffers
" nnoremap <leader><leader> <c-^>

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
" Quickly edit bundles file
nnoremap <silent> <leader>eb :e ~/.config/nvim/init/bundles.vim<CR>

" search and replace
nnoremap <leader>ss :%s/
vnoremap <leader>ss :s/

" case insensitive incsearch
nnoremap c/ /\c

" reflow paragraph (i.e. remove end of lines)
nnoremap Q gqap
" reflow selected text
vnoremap Q gq

command! CdHere :cd %:p:h

" NeoVim providers
" ================
" See https://neovim.io/doc/user/provider.html
let g:coc_node_path = expand('~/.nvm/versions/node/v14.15.4/bin/node')
let g:node_host_prog = expand('~/.nvm/versions/node/v14.15.4/bin/neovim-node-host')
let g:python3_host_prog = expand('~/.venv/py3nvim/bin/python')

" FUNCTIONS
" =========
function! s:InsertDate(day_offset)
    let l:time = localtime() + (24 * 3600 * a:day_offset)
    let l:line=line(".")
    call setline(l:line, strftime('%A, %d %B %Y', l:time))
    unlet l:line
endfunction

command! TodaysDate call s:InsertDate(0)
command! TomorrowsDate call s:InsertDate(1)

" delete current buffer without destroying split window
" (use function b/c I don't know how to string commands together)
function! s:DeleteCurrentBuffer()
    bn
    bd#
endfunction
command! BD call s:DeleteCurrentBuffer()

" Commands to edit syntax, ftplugin, and snippets based on current filetype
function! s:EditVimConfig(dir, ...)
    let extension =  a:0 >= 1  ?  a:1  :  '.vim'
    let cmd = 'edit ~/.config/nvim/' . a:dir . '/' . &filetype . extension
    execute cmd
endfunction
command! EditSyntax call s:EditVimConfig('syntax')
command! EditPlugin call s:EditVimConfig('ftplugin')
command! EditSnippet call s:EditVimConfig('snippets', '.snippets')
command! EditColors edit ~/.config/nvim/colors/molokai.vim

nnoremap <leader>ep :echo expand('%:p')<CR>

" Show syntax highlighting groups for word under cursor (Ctrl-Shift-P)
nnoremap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

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

" Set tabwidth
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

" Plugin Customization
" ====================

" Vimwiki configuration
" ......................................................................
let g:vimwiki_list = [
    \{'path': '$HOME/Dropbox/wiki',
    \ 'syntax': 'markdown',
    \ 'ext': 'md'}]
let g:vimwiki_global_ext = 0 " make sure vimwiki doesn't own all .md files

" riv plugin configuration
" ......................................................................
" Avoid maxmempattern error in riv
" See https://github.com/gu-fan/riv.vim/issues/144#issuecomment-537056690
set mmp=2000

" Project-level exuberant tags
" ......................................................................
let g:easytags_async=1
let g:easytags_auto_highlight=0
let g:easytags_dynamic_files = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" Disable this to prevent noticeable pause (See https://github.com/w0rp/ale/issues/2021)
let g:ale_virtualenv_dir_names = []

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

" vim-schlepp
vmap <up> <Plug>SchleppUp
vmap <down> <Plug>SchleppDown
vmap <left> <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight
vmap D <Plug>SchleppDup
let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlocks = 1

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

" Ignore files for Command-T
set wildignore+=*.o,*.so,*.bmp,*.gif,*.tif,*.jpg,*.png,*.pdf,*.mat,*.npz,*.aux,*.bbl,*.blg,*.log,*.key,*.pyc,*.fdb_latexmk,*.egg-info,*.png.map,*.egg
" IPython auto-generated files
set wildignore+=shadowhist,kernel*.json,__enamlcache__,build

" vim-jsx
" ......................................................................
let g:jsx_ext_required = 0  " Use vim-jsx for all .js files

" vim-closetag
" ......................................................................
let g:closetag_filenames = "*.html,*.js"

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

" UltiSnips
" ......................................................................
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

" vim-surround
" ......................................................................
let g:surround_{char2nr('w')} = "{{\r}}"
let g:surround_{char2nr('%')} = "{%\r%}"

" Python
" ......................................................................
" syntax/python.vim gets run before ftplugin/python.vim, so we must set this
" highlight option in vimrc instead of ftplugin.
let g:python_highlight_all = 1

" SimpylFold
" ......................................................................

let g:SimpylFold_docstring_preview = 1

" Allow project-specific `.nvimrc` files, but disable unsafe commands
" See https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure

" Typescript
" ......................................................................

" Override default link to Error for some reserved words (e.g import) peitalin/vim-jsx-typescript
hi link typescriptReserved Keyword
