" Use non-standard 'plugged' directory as suggested by vim-plug docs
" See https://github.com/junegunn/vim-plug
call plug#begin('~/dotfiles/vim/plugged')

" Vim enhancement plugins:
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'

" UI enhancement plugins:
Plug 'gerw/vim-HiLinkTrace'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/vim-peekaboo'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/junkfile.vim'
Plug 'tomasr/molokai'
Plug 'Yggdroot/indentLine'

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
Plug 'vim-scripts/ReplaceWithRegister'

" Motion and text-object plugins:
Plug 'andymass/vim-matchup'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-surround'

" Search and navigation plugins:
Plug 'ap/vim-buftabline'
Plug 'bronson/vim-visual-star-search'
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'padde/jump.vim'
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
Plug 'duganchen/vim-soy'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'gu-fan/riv.vim'
Plug 'jxnblk/vim-mdx-js'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', 'release'
Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'
Plug 'styled-components/vim-styled-components'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-ragtag'
Plug 'tweekmonster/django-plus.vim'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()
