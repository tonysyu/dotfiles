local opt = vim.opt
local utils = require('utils')

local map = utils.key_map_factory('', {})
local nnoremap = utils.key_map_factory('n', { noremap = true })
local onoremap = utils.key_map_factory('o', { noremap = true })
local vnoremap = utils.key_map_factory('v', { noremap = true })
local xnoremap = utils.key_map_factory('x', { noremap = true })

-- Vim configuration helpers
-- ............................................................................
-- Edit the vim configuration file (requires nvim-telescope)
nnoremap { '<leader>ev', '<cmd>lua require("telescope.builtin").find_files({ search_dirs={ "~/.config/nvim/" } })<cr>' }
-- Reload (source) the vim settings
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

-- vim line-object from https://vi.stackexchange.com/a/6102/12878
xnoremap { 'il', 'g_o0' }
onoremap { 'il', ':normal! vil<CR>' }
xnoremap { 'al', '$o0' }
onoremap { 'al', ':normal! val<CR>' }

-- Split buffer navigation
-- ............................................................................
nnoremap { '<C-h>', '<C-w>h' }
nnoremap { '<C-j>', '<C-w>j' }
nnoremap { '<C-k>', '<C-w>k' }
nnoremap { '<C-l>', '<C-w>l' }


-- Text formatting mappings
-- ............................................................................
-- reflow paragraph (i.e. remove end of lines)
nnoremap { 'Q', 'gqap' }
-- reflow selected text
vnoremap { 'Q', 'gq' }

-- File search mappings
-- ............................................................................
-- search and replace
nnoremap { '<leader>ss', ':%s/' }
vnoremap { '<leader>ss', ':s/' }

-- incsearch.vim settings
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
-- ............................................................................
nnoremap { '<leader>ff', '<cmd>lua require("telescope.builtin").git_files()<cr>' }
nnoremap { '<leader>fF', '<cmd>lua require("telescope.builtin").find_files()<cr>' }
nnoremap { '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>' }
nnoremap { '<leader>fG', '<cmd>lua require("telescope.builtin").grep_string()<cr>' }
nnoremap { '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>' }
nnoremap { '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>' }
nnoremap { '<leader>fm', '<cmd>lua require("telescope.builtin").marks()<cr>' }
nnoremap { '<leader>fr', '<cmd>lua require("telescope.builtin").registers()<cr>' }
