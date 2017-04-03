set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Vim enhancement plugins:
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'vim-scripts/Rename'

" UI enhancement plugins:
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'

" General editing plugins:
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'the-isz/MinYankRing.vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'bronson/vim-trailing-whitespace'

" Search and navigation plugins:
NeoBundle 'tpope/vim-surround'
NeoBundle 'bronson/vim-visual-star-search'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'mhinz/vim-grepper'
NeoBundle 'padde/jump.vim'
NeoBundle 'ap/vim-buftabline'

" Git plugins:
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" Language-specific plugins
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'jaxbot/syntastic-react'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
