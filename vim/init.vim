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

source ~/.config/nvim/init/languages.vim
source ~/.config/nvim/init/search_and_nav.vim
source ~/.config/nvim/init/ui.vim

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

" vim line-object from https://vi.stackexchange.com/a/6102/12878
xnoremap il g_o0
onoremap il :normal! vil<CR>
xnoremap al $o0
onoremap al :normal! val<CR>

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

" reflow paragraph (i.e. remove end of lines)
nnoremap Q gqap
" reflow selected text
vnoremap Q gq

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

" vim-schlepp
vmap <up> <Plug>SchleppUp
vmap <down> <Plug>SchleppDown
vmap <left> <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight
vmap D <Plug>SchleppDup
let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlocks = 1

" Ignore files for Command-T
set wildignore+=*.o,*.so,*.bmp,*.gif,*.tif,*.jpg,*.png,*.pdf,*.mat,*.npz,*.aux,*.bbl,*.blg,*.log,*.key,*.pyc,*.fdb_latexmk,*.egg-info,*.png.map,*.egg
" IPython auto-generated files
set wildignore+=shadowhist,kernel*.json,__enamlcache__,build

" vim-closetag
" ......................................................................
let g:closetag_filenames = "*.html,*.js"

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

" Allow project-specific `.nvimrc` files, but disable unsafe commands
" See https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure
