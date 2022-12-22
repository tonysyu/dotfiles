require('packer-config')

require('settings')
require('tools')
require('key_mappings')
require('lsp')
require('treesitter')

-- Old vimscript files not-yet converted to lua
local function source_vimscript(path)
  vim.cmd('source ' .. path)
end

source_vimscript('~/.config/nvim/init/highlight.vim')
source_vimscript('~/.config/nvim/init/search_and_nav.vim')
