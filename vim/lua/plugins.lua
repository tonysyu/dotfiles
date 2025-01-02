-- Packer setup based on https://github.com/nvim-lua/kickstart.nvim

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set mapleader and localleader to comma
-- lazy.nvim requires that this be set before setting up lazy.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set up dependencies
require("lazy").setup({
  -- LSP Configuration (see vim/lua/lsp.lua)
  -- ..........................................................................
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
  },

  'folke/neodev.nvim',             -- Additional lua configuration, makes nvim stuff amazing
  'simrat39/symbols-outline.nvim', -- Side pane LSP symbols

  --- Diagnostics
  -- ..........................................................................
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  -- Autocompletion
  -- ..........................................................................
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- AI Assitants
  -- ..........................................................................
  'github/copilot.vim',

  -- Treesitter (Highlight, edit, and navigate code)
  -- ..........................................................................
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      -- Adds :TSPlaygroundToggle to view Treesitter
      'nvim-treesitter/playground',
      -- Additional text objects via treesitter
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- Display code context
      'nvim-treesitter/nvim-treesitter-context'
    }
  },

  -- Language-specific plugins
  -- ..........................................................................
  'alvan/vim-closetag',
  'chrisbra/Colorizer',
  'elixir-editors/vim-elixir',
  'mattn/emmet-vim',
  'tpope/vim-ragtag',
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- use latest release, instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Motion and text-object plugins
  -- ..........................................................................
  'andymass/vim-matchup', -- Extends % to match non-traditional delimiters (e.g. begin/end)
  'tpope/vim-surround',   -- Easily add, change, and delete surrounding delimiters
  -- ..........................................................................

  -- Filesystem plugins
  -- ..........................................................................
  'nanotee/zoxide.vim',  -- Integrate with zoxide fuzzy directory matcher
  'Shougo/junkfile.vim', -- Quickly create junkfile
  'tpope/vim-eunuch',    -- Unix shell commands for file/directory management
  -- Filesystem explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  -- Git related plugins
  -- ..........................................................................
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',

  -- UI enhancements (see vim/after/plugin/ui-enhancements.lua)
  -- ..........................................................................
  'junegunn/vim-peekaboo',        -- Display the content of registers
  'kshenoy/vim-signature',        -- Display marks in the gutter
  'kyazdani42/nvim-web-devicons', -- Icons for languages, files, directories, etc.
  'nvim-lualine/lualine.nvim',    -- Fancier statusline

  -- Colorschemes/themes
  'catppuccin/nvim', -- Default colorscheme; don't lazy load
  { 'EdenEast/nightfox.nvim',      lazy = true },
  { 'folke/tokyonight.nvim',       lazy = true },
  { 'navarasu/onedark.nvim',       lazy = true },
  { 'projekt0n/github-nvim-theme', lazy = true },
  { 'sainnhe/sonokai',             lazy = true },

  -- Noice plugin for pretty cmdline, messages, and popups
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  -- snacks.nvim: A collection of quality-of-life plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Disables Treesitter and Lsp for large files
      bigfile = { enabled = true },
      -- Delete buffers while preserving window layout
      bufdelete = { enabled = true },
      -- Neovim startup dashboard
      dashboard = { enabled = true },
      -- indentation guide (indent-blankline alternative)
      indent = { enabled = true },
      -- Notification popup (integrates with folke/noice.nvim; replaces nvim-notify)
      notifier = { enabled = true },
      -- Embedded terminal (replaces toggleterm.nvim)
      terminal = {
        enabled = true,
        win = {
          style = "float",
        },
      },
      -- Render files before loading plugins
      quickfile = { enabled = true },
      words = { enabled = true },
    },
  },

  -- Editor configuration
  -- ..........................................................................
  'editorconfig/editorconfig-vim', -- Autodetect https://editorconfig.org/ files
  'tpope/vim-sleuth',              -- Detect tabstop and shiftwidth automatically

  -- General editing (see vim/after/plugin/general-editing.lua)
  -- ..........................................................................
  'AndrewRadev/splitjoin.vim',
  'jiangmiao/auto-pairs',
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'tpope/vim-abolish',
  'tpope/vim-endwise',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',

  -- Fuzzy Finder (files, lsp, etc)
  -- ..........................................................................
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable 'make' == 1,
  },
})
