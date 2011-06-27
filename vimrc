"remove vi compatibility (this should be first since it has side effects)
set nocompatible
" syntax highlighting on
colorscheme busybee
syntax on
" use pathogen to handle bundles
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set modelines=0                 " don't add configuration lines to files

" change the mapleader from \ to ,
let mapleader=","
let maplocalleader=","
" let semicolon start EX-mode (a.k.a. command mode)
"nnoremap ; :

set showcmd                     " show keys pressed in normal mode
set showmode                    " display mode in Insert, Replace or Visual
set cursorline                  " highlight current line
set laststatus=2                " always display statusline
set wildmode=longest,list,full  " change tab-completion to be more like BASH
set wildmenu                    " show alternate command-line completion
set scrolloff=3                 " minimum number of lines above/below current
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent
"set smartindent                 " not Python-friendly: wants brackets

" Whitespace
" set list                        " show whitespace (negates linebreak)
set listchars=tab:▸\ ,eol:¬     " set tab and end of line characters
set tabstop=4                   " tab is 4 spaces
set shiftwidth=4                " indentation in normal mode is 4 spaces
set softtabstop=4               " back space removes up-to 4 spaces
set expandtab                   " expand tabs to spaces

" line width and indenting
set wrap
set linebreak                   " set list and set linebreak conflict!
set textwidth=79
set formatoptions=qrn1

if v:version >= 703             " options only available in VIM 7.3
    set number                  " show line numbers
    set relativenumber          " number lines relative to current line
    set colorcolumn=80          " add line marking column
    set undofile                " allow undo across file sessions
endif

" Search customization
" ====================
" Change search regex to match those in Python
set incsearch                   " turn on incremental search
set nohlsearch                  " don't highlight search words
set gdefault                    " make substitutions global by default
" toggle search matches when entering/leaving insert mode
"autocmd InsertEnter * :set nohlsearch
"autocmd InsertLeave * :set hlsearch
" turn off search with key command
"nnoremap <silent> <leader><space> :nohlsearch<CR>

" Change to directory of active buffer
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
autocmd BufNewFile,BufRead *.cir set filetype=spice

autocmd BufLeave,FocusLost silent! wall " save when focus is lost
" Since I'm auto-saving (above), don't save backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" Allow switching from modified buffers (i.e. hidden buffers)
set hidden
" Confirm before quitting if a modified buffer is hidden
set confirm

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

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

" Yank and paste from clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" Insert lines without going insert mode (screws up quickfix)
"nnoremap <S-Enter> O<Esc>
"nnoremap <CR> o<Esc>
" Commands
" ========
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>ss :%s/
vnoremap <leader>ss :s/

" wrap both vimdiff windows
nmap <silent> <leader>dw <C-w>= :set wrap<CR> <C-w><C-w> :set wrap<CR>

" jj in insert mode will change to normal mode
inoremap jj <ESC>

" reflow paragraph (i.e. remove end of lines)
nnoremap Q gqap
" reflow selected text
vnoremap Q gq

" Shortcuts for fugitive.vim plugin
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gw :Gwrite<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gd :Gdiff<cr>
"switch back to current file and closes fugitive buffer
nnoremap <Leader>gf :diffoff!<cr><c-w>h:bd<cr>

" FUNCTIONS
" =========

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
    let cmd = 'edit ~/.vim/' . a:dir . '/' . &filetype . extension
    execute cmd
endfunction
command! EditSyntax call s:EditVimConfig('syntax')
command! EditPlugin call s:EditVimConfig('ftplugin')
command! EditSnippet call s:EditVimConfig('snippets', '.snippets')
command! EditColors edit ~/.vim/colors/tsy.vim

" Show syntax highlighting groups for word under cursor (Ctrl-Shift-P)
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Plugin Customization
" ====================

" Ignore files for Command-T
set wildignore+=*.o,*.so,*.bmp,*.gif,*.tif,*.jpg,*.png,*.pdf,*.mat,*.npz

" Default VCS prefix is ',c' which conflicts with NERD commenter
let VCSCommandMapPrefix = ',v'


" Launch lusty juggler (which lists buffers, hence "b")
nmap <silent> <leader>b <leader>lj

" Quick Ack-vim usage (note that space at the end makes it use easier)
nmap <leader>a :Ack 

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

nmap <silent> <leader>nt :NERDTreeToggle<CR>

" When I use vim from the command line I get ruby-not-installed warnings
" even though ruby *is* installed; whatever, just ignore
let g:LustyExplorerSuppressRubyWarning = 1

