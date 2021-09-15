local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Vim configuration helpers
-- ............................................................................
-- Quickly edit/reload the vimrc file
bind('n', '<leader>ev', ':e $MYVIMRC<CR>', opts)
bind('n', '<leader>sv', ':so $MYVIMRC<CR>', opts)
-- Quickly edit bundles file
bind('n', '<leader>eb', ':e ~/.config/nvim/init/bundles.vim<CR>', opts)

-- Buffer navigation
-- ............................................................................
-- Toggle between two, most-recent buffers
bind('n', '<leader><leader>', '<c-^>', opts)

-- File info
-- ............................................................................
-- Show current path
bind('n', '<leader>ep' ,":echo expand('%:p')<CR>", opts)
