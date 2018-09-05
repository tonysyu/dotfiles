set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Vim enhancement plugins:
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'w0rp/ale'

" UI enhancement plugins:
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'haya14busa/incsearch.vim'

" General editing plugins:
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'christoomey/vim-system-copy'
NeoBundle 'the-isz/MinYankRing.vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'vim-scripts/ReplaceWithRegister'
NeoBundle 'zirrostig/vim-schlepp'

" Motion and text-object plugins:
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'tpope/vim-surround'

" Search and navigation plugins:
NeoBundle 'ap/vim-buftabline'
NeoBundle 'bronson/vim-visual-star-search'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'jeetsukumaran/vim-filebeagle'
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'padde/jump.vim'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-easytags'

" Git plugins:
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'junegunn/gv.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-unimpaired'

" Language-specific plugins
NeoBundle 'alvan/vim-closetag'
NeoBundle 'chrisbra/Colorizer'
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'duganchen/vim-soy'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'posva/vim-vue'
NeoBundle 'tmhedberg/SimpylFold'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'tweekmonster/django-plus.vim'
NeoBundle 'vim-scripts/confluencewiki.vim'
NeoBundle 'Vimjas/vim-python-pep8-indent'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
