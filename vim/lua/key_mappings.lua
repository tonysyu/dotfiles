local bind = vim.api.nvim_set_keymap
local opt = vim.opt

local function key_map_factory(mapping_type, options)
    return function(args)
        key, command = unpack(args)
        return bind(mapping_type, key, command, options)
    end
end

local map = key_map_factory('', {})
local nnoremap = key_map_factory('n', { noremap = true, silent = true })
local vnoremap = key_map_factory('v', { noremap = true, silent = true })

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

-- Line and column navigation
-- ............................................................................
-- Change j, k, ^, $ to move by screen line instead of file line (wrapped lines)
nnoremap { 'j', 'gj' }
nnoremap { 'k', 'gk' }
nnoremap { '$', 'g$' }
nnoremap { '^', 'g^' }
vnoremap { 'j', 'gj' }
vnoremap { 'k', 'gk' }
vnoremap { '$', 'g$' }
vnoremap { '^', 'g^' }

-- Split buffer navigation
-- ............................................................................
nnoremap { '<C-h>', '<C-w>h' }
nnoremap { '<C-j>', '<C-w>j' }
nnoremap { '<C-k>', '<C-w>k' }
nnoremap { '<C-l>', '<C-w>l' }

-- incsearch.vim settings
-- ......................................................................
map { '/', '<Plug>(incsearch-forward)' }
map { '?', '<Plug>(incsearch-backward)' }
map { 'g/', '<Plug>(incsearch-stay)' }
-- https://vi.stackexchange.com/a/8742
opt.hlsearch = true
vim.g['incsearch#auto_nohlsearch'] = 1
map { 'n', '<Plug>(incsearch-nohl-n)' }
map { 'N', '<Plug>(incsearch-nohl-N)' }
map { '*', '<Plug>(incsearch-nohl-*)' }
map { '#', '<Plug>(incsearch-nohl-#)' }
map { 'g*', '<Plug>(incsearch-nohl-g*)' }
map { 'g#', '<Plug>(incsearch-nohl-g#)' }

-- Telescope
-- ......................................................................
nnoremap { '<leader>ff', '<cmd>lua require("telescope.builtin").git_files()<cr>' }
nnoremap { '<leader>fF', '<cmd>lua require("telescope.builtin").find_files()<cr>' }
nnoremap { '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep diff()<cr>' }
nnoremap { '<leader>fG', '<cmd>lua require("telescope.builtin").grep_string()<cr>' }
nnoremap { '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>' }
nnoremap { '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>' }
