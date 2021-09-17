local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local function nnoremap(args)
    key, command = unpack(args)
    return bind('n', key, command, opts)
end

-- Vim configuration helpers
-- ............................................................................
-- Quickly edit/reload the vimrc file
nnoremap { '<leader>ev', ':e $MYVIMRC<CR>' }
nnoremap { '<leader>sv', ':so $MYVIMRC<CR>' }
-- Quickly edit bundles file
nnoremap { '<leader>eb', ':e ~/.config/nvim/init/bundles.vim<CR>' }

-- Buffer navigation
-- ............................................................................
-- Toggle between two, most-recent buffers
nnoremap { '<leader><leader>', '<c-^>' }

-- File info
-- ............................................................................
-- Show current path
nnoremap { '<leader>ep' ,":echo expand('%:p')<CR>" }
