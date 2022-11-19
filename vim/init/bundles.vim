" Use non-standard 'plugged' directory as suggested by vim-plug docs
" See https://github.com/junegunn/vim-plug
call plug#begin('~/dotfiles/vim/plugged')

" Vim enhancement plugins:
Plug 'editorconfig/editorconfig-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Completion plugins
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
" See https://github.com/quangnguyen30192/cmp-nvim-ultisnips/issues/67
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Filesystem plugins
Plug 'Shougo/junkfile.vim'
Plug 'tpope/vim-eunuch'

" UI enhancement plugins:
Plug 'folke/trouble.nvim'
Plug 'gerw/vim-HiLinkTrace'
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/vim-peekaboo'
Plug 'simrat39/symbols-outline.nvim'
Plug 'tomasr/molokai'

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
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'tpope/vim-surround'

" Telescope (search) plugins:
Plug 'nvim-lua/plenary.nvim'  " Required by nvim-telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Search and navigation plugins:
Plug 'ap/vim-buftabline'
Plug 'nelstrom/vim-visual-star-search'
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
Plug 'elixir-editors/vim-elixir'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-ragtag'

" Vim introspection and debugging
Plug 'rafcamlet/nvim-luapad'

call plug#end()
