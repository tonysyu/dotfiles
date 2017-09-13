set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Vim enhancement plugins:
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'w0rp/ale'

" UI enhancement plugins:
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'haya14busa/incsearch.vim'

" General editing plugins:
NeoBundle 'christoomey/vim-system-copy'
NeoBundle 'the-isz/MinYankRing.vim'
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
NeoBundle 'bronson/vim-visual-star-search'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'mhinz/vim-grepper'
NeoBundle 'padde/jump.vim'
NeoBundle 'ap/vim-buftabline'
NeoBundle 'jeetsukumaran/vim-filebeagle'

" Git plugins:
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'junegunn/gv.vim'

" Language-specific plugins
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'alvan/vim-closetag'
NeoBundle 'vim-scripts/confluencewiki.vim'
NeoBundle 'tweekmonster/django-plus.vim'
NeoBundle 'Vimjas/vim-python-pep8-indent'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
