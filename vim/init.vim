syntax on

source ~/.config/nvim/init/bundles.vim

" change the mapleader from \ to ,
let mapleader=","
let maplocalleader=","

luafile ~/.config/nvim/lua/settings.lua

" Setup colorscheme
set termguicolors
set background=dark
colorscheme molokai

" Search
set wildignorecase              " Ignore case in file searches (e.g. in ex mode)

" line width and indenting
set formatoptions=qrn1

luafile ~/.config/nvim/init/lsp.lua
luafile ~/.config/nvim/init/treesitter.lua
source ~/.config/nvim/init/editing.vim
source ~/.config/nvim/init/highlight.vim
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
