"remove vi compatibility (this should be first since it has side effects)
set nocompatible
" syntax highlighting on

" Set vim to use colorschemes with 256 colors
set t_Co=256
set background=dark
colorscheme molokai

let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')

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
    autocmd BufNewFile,BufRead,BufFilePost *.txt set filetype=rst
    autocmd BufNewFile,BufRead,BufFilePost *.tex set filetype=tex
    autocmd BufNewFile,BufRead,BufFilePost *.cls set filetype=tex
    autocmd BufNewFile,BufRead,BufFilePost *.css_t set filetype=css
    autocmd BufNewFile,BufRead,BufFilePost *.enaml set filetype=enaml
    autocmd BufNewFile,BufRead,BufFilePost *.json set filetype=javascript
    autocmd BufNewFile,BufRead,BufFilePost *.wiki set filetype=confluencewiki
    autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
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

" Toggle between two, most-recent buffers
nnoremap <leader><leader> <c-^>

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
" Quickly edit bundles file
nnoremap <silent> <leader>eb :e ~/.config/nvim/init/bundles.vim<CR>

" search and replace
nnoremap <leader>ss :%s/
vnoremap <leader>ss :s/

" reflow paragraph (i.e. remove end of lines)
nnoremap Q gqap
" reflow selected text
vnoremap Q gq

command! CdHere :cd %:p:h

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

" Plugin Customization
" ====================

" Project-level exuberant tags
" ......................................................................
let g:easytags_async=1
let g:easytags_auto_highlight=0
let g:easytags_dynamic_files = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

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

" Syntastic
" ......................................................................
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

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

" YouCompleteMe
" ......................................................................
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" Experimentally integrate YouCompleteMe with vim-multiple-cursors, otherwise
" the numerous Cursor events cause great slowness
" (https://github.com/kristijanhusak/vim-multiple-cursors/issues/4)
function! Multiple_cursors_before()
  let s:old_ycm_whitelist = g:ycm_filetype_whitelist
  let g:ycm_filetype_whitelist = {}
endfunction
function! Multiple_cursors_after()
  let g:ycm_filetype_whitelist = s:old_ycm_whitelist
endfunction

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

let g:syntastic_python_flake8_config_file='.flake8'

" SimpylFold
" ......................................................................

let g:SimpylFold_docstring_preview = 1

" Django centric commands
" ......................................................................

let g:last_relative_dir = ''
command! Djadmin call s:DjRelatedFile("admin.py")
command! Djforms call s:DjRelatedFile("forms.py")
command! Djmodels call s:DjRelatedFile("models.py")
command! Djtests call s:DjRelatedFile("tests.py")
command! Djurls call s:DjRelatedFile("urls.py")
command! Djviews call s:DjRelatedFile("views.py")
command! Djmigrations call s:DjRelatedFile("migrations/")
command! Djtemplates call s:DjRelatedFile("templates/")

function! s:DjRelatedFile(file)
    " This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

function! SetDjAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun

augroup django_config
    autocmd!
    autocmd BufEnter *.py call SetDjAppDir()
augroup END

" Allow project-specific `.nvimrc` files, but disable unsafe commands
" See https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure
