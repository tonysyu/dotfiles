" Use non-standard 'plugged' directory as suggested by vim-plug docs
" See https://github.com/junegunn/vim-plug
call plug#begin('~/dotfiles/vim/plugged')

" Vim enhancement plugins:
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'

" UI enhancement plugins:
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Shougo/junkfile.vim'

" General editing plugins:
Plug 'AndrewRadev/splitjoin.vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'zirrostig/vim-schlepp'

" Motion and text-object plugins:
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-surround'

" Search and navigation plugins:
Plug 'ap/vim-buftabline'
Plug 'bronson/vim-visual-star-search'
Plug 'easymotion/vim-easymotion'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'padde/jump.vim'
Plug 'tmhedberg/matchit'
Plug 'xolox/vim-misc'

" Git plugins:
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

" Language-specific plugins
Plug 'alvan/vim-closetag'
Plug 'cespare/vim-toml'
Plug 'chrisbra/Colorizer'
Plug 'chrisbra/csv.vim'
Plug 'neoclide/coc.nvim', 'release'
Plug 'duganchen/vim-soy'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'gu-fan/riv.vim'
Plug 'jxnblk/vim-mdx-js'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'
Plug 'styled-components/vim-styled-components'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-ragtag'
Plug 'tweekmonster/django-plus.vim'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()
