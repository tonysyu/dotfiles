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

luafile ~/.config/nvim/init/lsp.lua
luafile ~/.config/nvim/init/treesitter.lua
source ~/.config/nvim/init/editing.vim
source ~/.config/nvim/init/highlight.vim
source ~/.config/nvim/init/languages.vim
source ~/.config/nvim/init/search_and_nav.vim
source ~/.config/nvim/init/ui.vim


" Ctrl-/ to start case-insensitive search
nnoremap <C-/> :/\c

" Disable most-recent buffer toggle to avoid conflicts with easymotion
" Toggle between two, most-recent buffers
nnoremap <leader><leader> <c-^>

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
" Quickly edit bundles file
nnoremap <silent> <leader>eb :e ~/.config/nvim/init/bundles.vim<CR>

nnoremap <leader>ep :echo expand('%:p')<CR>

" NeoVim providers
" ================
" See https://neovim.io/doc/user/provider.html
let g:node_host_prog = expand('~/.nvm/versions/node/v14.15.4/bin/neovim-node-host')
let g:python3_host_prog = expand('~/.venv/py3nvim/bin/python')
