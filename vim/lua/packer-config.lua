-- Packer setup based on https://github.com/nvim-lua/kickstart.nvim

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- LSP Configuration (see vim/lua/lsp.lua)
  -- ..........................................................................
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
  }

  use "folke/neodev.nvim" -- Additional lua configuration, makes nvim stuff amazing
  use 'simrat39/symbols-outline.nvim' -- Side pane LSP symbols

  --- Diagnostics
  -- ..........................................................................
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Autocompletion
  -- ..........................................................................
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- Treesitter (Highlight, edit, and navigate code)
  -- ..........................................................................
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  -- Adds :TSPlaygroundToggle to view Treesitter
  use {
    'nvim-treesitter/playground',
    after = 'nvim-treesitter',
  }

  -- Language-specific plugins
  -- ..........................................................................
  use 'alvan/vim-closetag'
  use 'chrisbra/Colorizer'
  use 'elixir-editors/vim-elixir'
  use 'mattn/emmet-vim'
  use 'tpope/vim-ragtag'

  -- Motion and text-object plugins
  -- ..........................................................................
  -- Additional text objects via treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use 'andymass/vim-matchup' -- Extends % to match non-traditional delimiters (e.g. begin/end)
  use 'tpope/vim-surround' -- Easily add, change, and delete surrounding delimiters
  -- ..........................................................................

  -- Filesystem plugins
  -- ..........................................................................
  use 'nanotee/zoxide.vim' -- Integrate with zoxide fuzzy directory matcher
  use 'padde/jump.vim' -- Vim integration with autojump fuzzy directory matcher
  use 'Shougo/junkfile.vim' -- Quickly create junkfile
  use 'tpope/vim-eunuch' -- Unix shell commands for file/directory management

  -- Git related plugins
  -- ..........................................................................
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- UI enhancements (see vim/after/plugin/ui-enhancements.lua)
  -- ..........................................................................
  use 'junegunn/vim-peekaboo' -- Display the content of registers
  use 'kshenoy/vim-signature' -- Display marks in the gutter
  use 'kyazdani42/nvim-web-devicons' -- Icons for languages, files, directories, etc.
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline

  -- Colorschemes/themes
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
  use 'ofirgall/ofirkai.nvim'
  use 'projekt0n/github-nvim-theme'
  use 'sainnhe/sonokai'

  -- Editor configuration
  -- ..........................................................................
  use 'editorconfig/editorconfig-vim' -- Autodetect https://editorconfig.org/ files
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- General editing (see vim/after/plugin/general_editing.lua)
  -- ..........................................................................
  use 'AndrewRadev/splitjoin.vim'
  use 'jiangmiao/auto-pairs'
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-abolish'
  use 'tpope/vim-endwise'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'

  -- Fuzzy Finder (files, lsp, etc)
  -- ..........................................................................
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1,
  }

  -- Set up custom plugins
  -- ..........................................................................
  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  -- Finish bootstrap sync
  -- ..........................................................................
  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

