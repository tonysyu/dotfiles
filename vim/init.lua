local function source_vimscript(path)
    vim.cmd('source ' .. path)
end

source_vimscript("~/.config/nvim/init/bundles.vim")

-- Set mapleader and localleader to comma
vim.g.mapleader = ','
vim.g.maplocalleader = ','

require('settings')
require('tools')
require('key_mappings')
require('lsp')
require('treesitter')

-- Old vimscript files not-yet converted to lua
source_vimscript('~/.config/nvim/init/editing.vim')
source_vimscript('~/.config/nvim/init/highlight.vim')
source_vimscript('~/.config/nvim/init/languages.vim')
source_vimscript('~/.config/nvim/init/search_and_nav.vim')
