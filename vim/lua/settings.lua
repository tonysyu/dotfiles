local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

-- Setup colorscheme
-- ............................................................................
cmd('colorscheme molokai')
opt.background = 'dark'
opt.termguicolors = true

-- NeoVim providers
-- ............................................................................
-- See https://neovim.io/doc/user/provider.html
g.node_host_prog = '~/.nvm/versions/node/v14.15.4/bin/neovim-node-host'
g.python3_host_prog = '~/.venv/py3nvim/bin/python'

-- Indentation
-- ............................................................................
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Undo
-- ............................................................................
opt.undofile = true
opt.undodir = '~/.config/nvim/undo/'

-- Modified buffers, backups, and swap files
-- ............................................................................
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.hidden = true  -- Allow switching from modified buffers (i.e. hidden buffers)
opt.confirm = true  -- Confirm before quitting if a modified buffer is hidden

-- Fill column
-- ............................................................................
opt.textwidth = 99
opt.colorcolumn = '+1'

-- Linebreak and wrap behavior
-- ............................................................................
opt.linebreak = true
opt.breakindent = true
opt.showbreak = '↪'

-- Line numbers
-- ............................................................................
opt.number = true
opt.relativenumber = true

-- Wildmenu (ex-mode completion)
-- ............................................................................
opt.wildignorecase = true  -- Ignore case in file searches
opt.wildmenu = true
opt.wildmode = {'longest', 'list', 'full'}

-- Cursor
-- ............................................................................
opt.cursorline = true

-- Whitespace
-- ............................................................................
opt.list = true
opt.listchars = { tab='» ', extends='›', precedes='‹', nbsp='·', trail='·' }

-- Search
-- ............................................................................
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true

-- Project specific vimrc with secure
-- ............................................................................
opt.exrc = true
opt.secure = true

-- File search configuration
-- ............................................................................
opt.wildignore = {
    -- Build files
    '*.a',
    '*.o',
    '*.so',
    'build',
    -- Log files
    '*.log',
    -- Images
    '*.bmp',
    '*.gif',
    '*.jpg',
    '*.png',
    '*.png.map',
    '*.pdf',
    '*.tif',
    -- Python files
    '__pycache__',
    '*.egg',
    '*.egg-info',
    '*.pyc',
    -- IPython files
    'shadowhist','kernel*.json','__enamlcache__',
    -- LaTeX files
    '*.aux',
    '*.bbl',
    '*.blg',
    '*.fdb_latexmk',
}

-- Folding (with Treesitter)
-- ............................................................................
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99
