local opt = vim.opt
local utils = require('utils')
local legendary = require('legendary')


local map = utils.key_map_factory('', {})
local nnoremap = utils.key_map_factory('n', { noremap = true })
local onoremap = utils.key_map_factory('o', { noremap = true })
local vnoremap = utils.key_map_factory('v', { noremap = true })
local xnoremap = utils.key_map_factory('x', { noremap = true })


legendary.setup({
    keymaps = {
        -- Code file search
        -- ............................................................................
        { '<leader>ff', '<cmd>lua require("telescope.builtin").git_files()<cr>', description = 'Find git files' },
        { '<leader>fF', '<cmd>lua require("telescope.builtin").find_files()<cr>', description = 'Find all files' },
        { '<leader>gb', '<cmd>lua require("telescope.builtin").git_branches()<cr>', description = 'Find git branches' },

        -- Code text search
        -- ............................................................................
        { '<leader>fs', ':SymbolsOutline<cr>' , description = 'Find symbols' },
        { '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', description = 'Find text using grep/search' },
        { '/w', '<cmd>lua require("telescope.builtin").grep_string()<cr>', description = 'Find string under cursor' },
        { '<leader>ss', { n = ':%s/', v = ':s/' }, description = 'Find and replace using regex' },

        -- Buffer navigation
        -- ............................................................................
        { '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', description = 'Find buffer' },
        { '<leader><leader>', '<c-^>', description = 'Toggle between two, most-recent buffers' },

        -- Split buffer navigation
        -- ............................................................................
        { '<C-j>', '<C-w>j', description = 'Switch to buffer/pane below' },
        { '<C-k>', '<C-w>k', description = 'Switch to buffer/pane above ' },
        { '<C-h>', '<C-w>h', description = 'Switch to buffer/pane on left' },
        { '<C-l>', '<C-w>l', description = 'Switch to buffer/pane on right' },

        -- Move text line-by-line (see https://youtu.be/hSHATqh8svM)
        -- ............................................................................
        { 'J', { v = ":m '>+1<CR>gv=gv" }, description = 'Move selected text down' },
        { 'K', { v = ":m '<-2<CR>gv=gv" }, description = 'Move selected text up' },
        { '<leader>j', ':m .+1<CR>==', description = 'Move line down' },
        { '<leader>k', ':m .-2<CR>==', description = 'Move line up' },


        -- Text formatting mappings
        -- ............................................................................
        { 'Q', 'gqap', description = 'Reflow paragraph (i.e. remove end of lines)' },
        { 'Q', { v = 'gq' }, description = 'Reflow selected text' },

        -- Echo status info
        -- ............................................................................
        -- Show current path
        { '<leader>ep' ,":echo expand('%:p')<CR>", description = 'Show/echo current path' },

        -- View helper windows
        -- ............................................................................
        nnoremap { '<leader>vq', '<cmd>lua require("utils").toggle_quickfix()<CR>', description = 'View/toggle quickfix window' },
        nnoremap { '<leader>vd', ':TroubleToggle document_diagnostics<CR>', description = 'View/toggle Trouble diagnostics' },

        -- Vim tool search
        -- ............................................................................
        { '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', description = 'Find help tags' },
        { '<leader>fk', ':Legendary<cr>' , description = 'Find keymappings/keybindings'},
        { '<leader>fc', '<cmd>lua require("telescope.builtin").commands()<cr>', description = 'Find commands' },
        { '<leader>fm', '<cmd>lua require("telescope.builtin").marks()<cr>', description = 'Find marks' },
        { '<leader>fr', '<cmd>lua require("telescope.builtin").registers()<cr>', description = 'Find registers' },

        -- Vim configuration helpers
        -- ............................................................................
        {
            '<leader>ev',
            '<cmd>lua require("telescope.builtin").find_files({ search_dirs={ "~/.config/nvim/" } })<cr>',
            description = 'Find vim configuration file'
        },
        { '<leader>sv', ':so $MYVIMRC<CR>', description = 'Reload (source) the vim settings' },
        { '<leader>eb', ':e ~/.config/nvim/init/bundles.vim<CR>', description = 'Quickly edit vim bundles file' },
    }
})


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


-- Keep cursor fixed
-- ............................................................................
-- Keep cursor centered when jumping through search results (zz; zv opens folds)
-- See https://youtu.be/hSHATqh8svM
nnoremap { 'n', 'nzzzv' }
nnoremap { 'N', 'Nzzzv' }
-- Keep cursor in same position (instead of going to EOL) when joining lines.
-- See https://youtu.be/hSHATqh8svM
nnoremap { 'J', 'mzJ`z' }
