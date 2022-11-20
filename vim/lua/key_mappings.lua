-- Code file search
-- ............................................................................
vim.keymap.set('n', '<leader>ff', '<cmd>lua require("telescope.builtin").git_files()<cr>', { desc = 'Find git files' })
vim.keymap.set('n', '<leader>fF', '<cmd>lua require("telescope.builtin").find_files()<cr>', { desc = 'Find all files' })
vim.keymap.set('n', '<leader>gb', '<cmd>lua require("telescope.builtin").git_branches()<cr>', { desc = 'Find git branches' })

-- Code text search
-- ............................................................................
vim.keymap.set('n', '<leader>fs', ':SymbolsOutline<cr>' , { desc = 'Find symbols' })
vim.keymap.set('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { desc = 'Find text using grep/search' })
vim.keymap.set('n', '/w', '<cmd>lua require("telescope.builtin").grep_string()<cr>', { desc = 'Find string under cursor' })
vim.keymap.set('n', '<leader>ss', ':%s/', { desc = 'Find and replace using regex' })
vim.keymap.set('v', '<leader>ss', ':s/', { desc = 'Find and replace using regex' })

-- Buffer navigation
-- ............................................................................
vim.keymap.set('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { desc = 'Find buffer' })
vim.keymap.set('n', '<leader><leader>', '<c-^>', { desc = 'Toggle between two, most-recent buffers' })

-- Split buffer navigation
-- ............................................................................
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Switch to buffer/pane below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Switch to buffer/pane above ' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Switch to buffer/pane on left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Switch to buffer/pane on right' })

-- Move text line-by-line (see https://youtu.be/hSHATqh8svM)
-- ............................................................................
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected text up' })
vim.keymap.set('n', '<leader>j', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<leader>k', ':m .-2<CR>==', { desc = 'Move line up' })


-- Text formatting mappings
-- ............................................................................
vim.keymap.set('n', 'Q', 'gqap', { desc = 'Reflow paragraph (i.e. remove end of lines)' })
vim.keymap.set('v', 'Q', 'gq', { desc = 'Reflow selected text' })

-- Echo status info
-- ............................................................................
vim.keymap.set('n', '<leader>ep' ,":echo expand('%:p')<CR>", { desc = 'Show/echo current path' })

-- View helper windows
-- ............................................................................
vim.keymap.set('n', '<leader>vq', '<cmd>lua require("utils").toggle_quickfix()<CR>', { desc = 'View/toggle quickfix window' })
vim.keymap.set('n', '<leader>vd', ':TroubleToggle document_diagnostics<CR>', { desc = 'View/toggle Trouble diagnostics' })

-- Vim tool search
-- ............................................................................
vim.keymap.set('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { desc = 'Find help tags' })
vim.keymap.set('n', '<leader>fk', '<cmd>lua require("telescope.builtin").keymaps()<cr>' , { desc = 'Find keymappings/keybindings' })
vim.keymap.set('n', '<leader>fc', '<cmd>lua require("telescope.builtin").commands()<cr>', { desc = 'Find commands' })
vim.keymap.set('n', '<leader>fm', '<cmd>lua require("telescope.builtin").marks()<cr>', { desc = 'Find marks' })
vim.keymap.set('n', '<leader>fr', '<cmd>lua require("telescope.builtin").registers()<cr>', { desc = 'Find registers' })

-- Vim configuration helpers
-- ............................................................................
vim.keymap.set('n', '<leader>ev', '<cmd>lua require("telescope.builtin").find_files({ search_dirs={ "~/.config/nvim/" } })<cr>', { desc = 'Find vim configuration file' })
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { desc = 'Reload (source) the vim settings' })
vim.keymap.set('n', '<leader>eb', ':e ~/.config/nvim/init/bundles.vim<CR>', { desc = 'Quickly edit vim bundles file' })


-- Line and column navigation
-- ............................................................................
-- Change j, k, ^, $ to move by screen line instead of file line (wrapped lines)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '$', 'g$')
vim.keymap.set('n', '^', 'g^')
vim.keymap.set('v', 'j', 'gj')
vim.keymap.set('v', 'k', 'gk')
vim.keymap.set('v', '$', 'g$')
vim.keymap.set('v', '^', 'g^')

-- vim line-object from https://vi.stackexchange.com/a/6102/12878
vim.keymap.set('x', 'il', 'g_o0')
vim.keymap.set('o', 'il', ':normal! vil<CR>')
vim.keymap.set('x', 'al', '$o0')
vim.keymap.set('o', 'al', ':normal! val<CR>')


-- Keep cursor fixed
-- ............................................................................
-- Keep cursor centered when jumping through search results (zz; zv opens folds)
-- See https://youtu.be/hSHATqh8svM
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- Keep cursor in same position (instead of going to EOL) when joining lines.
-- See https://youtu.be/hSHATqh8svM
vim.keymap.set('n', 'J', 'mzJ`z')
