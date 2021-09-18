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

luafile ~/.config/nvim/lua/load_tools_config.lua
luafile ~/.config/nvim/lua/key_mappings.lua
luafile ~/.config/nvim/lua/lsp.lua
luafile ~/.config/nvim/lua/treesitter.lua
source ~/.config/nvim/init/editing.vim
source ~/.config/nvim/init/highlight.vim
source ~/.config/nvim/init/languages.vim
source ~/.config/nvim/init/search_and_nav.vim
source ~/.config/nvim/init/ui.vim

" NeoVim providers
" ================
" See https://neovim.io/doc/user/provider.html
let g:node_host_prog = expand('~/.nvm/versions/node/v14.15.4/bin/neovim-node-host')
let g:python3_host_prog = expand('~/.venv/py3nvim/bin/python')
