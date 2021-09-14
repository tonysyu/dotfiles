local opt = vim.opt

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

-- Line numbers
-- ............................................................................
opt.number = true
opt.relativenumber = true

-- Wildmenu (ex-mode completion)
-- ............................................................................
opt.wildmode = {'longest', 'list', 'full'}
opt.wildmenu = true

-- Cursor
-- ............................................................................
opt.cursorline = true

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
vim.opt.wildignore = {
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
-- FIXME: Disable folding, which breaks syntax highlighting
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- opt.foldlevel = 99
