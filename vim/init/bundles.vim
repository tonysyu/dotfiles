" Use non-standard 'plugged' directory as suggested by vim-plug docs
" See https://github.com/junegunn/vim-plug
call plug#begin('~/dotfiles/vim/plugged')

" Vim enhancement plugins:
Plug 'editorconfig/editorconfig-vim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Filesystem plugins
Plug 'Shougo/junkfile.vim'
Plug 'tpope/vim-eunuch'

" UI enhancement plugins:
Plug 'gerw/vim-HiLinkTrace'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/vim-peekaboo'
Plug 'tomasr/molokai'
Plug 'Yggdroot/indentLine'

" General editing plugins:
Plug 'AndrewRadev/splitjoin.vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
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
Plug 'liuchengxu/vista.vim'
Plug 'justinmk/vim-sneak'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nelstrom/vim-visual-star-search'
Plug 'nvim-lua/plenary.nvim'  " Required by nvim-telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'padde/jump.vim'
Plug 'xolox/vim-misc'

" Git plugins:
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

" Language-specific plugins
Plug 'alvan/vim-closetag'
Plug 'chrisbra/Colorizer'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-ragtag'

call plug#end()
