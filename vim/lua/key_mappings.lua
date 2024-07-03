local telescope_builtin = require('telescope.builtin')
local utils = require('utils')

-- Prefer `<leader>f` as keymap for find/search that requires input
-- Prefer `<leader>s` as keymap for find/search that uses the current word
-- Prefer `<leader>v` as keymap for viewing panes and find/search is vim-specific

-- Code file search
-- ............................................................................
vim.keymap.set('n', '<leader>ff', telescope_builtin.git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<leader>fF', telescope_builtin.find_files, { desc = 'Find all files' })

-- Code text search
-- ............................................................................
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Find/search text using grep/search' })
vim.keymap.set('n', '<leader>*', telescope_builtin.grep_string, { desc = 'Find/search string under cursor' })
vim.keymap.set('n', '<leader>S', ':%s/', { desc = 'Find/search and replace using regex' })
vim.keymap.set('v', '<leader>S', ':s/', { desc = 'Find/search and replace using regex' })
vim.keymap.set('n', '<leader>/', telescope_builtin.current_buffer_fuzzy_find,
    { desc = 'Fuzzy find/search in current buffer' })

-- Undo ignorecase for star search
vim.keymap.set('n', '*', utils.find_current_word_without_ignorecase,
    { desc = 'Find/search current word under the cursor' })

-- Git search
-- ............................................................................
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches, { desc = 'Find/list git branches' })
vim.keymap.set('n', '<leader>gc', telescope_builtin.git_commits, { desc = 'Find/list git commits' })
vim.keymap.set('n', '<leader>gs', telescope_builtin.git_stash, { desc = 'Find/list git stash items' })

-- Buffer navigation
-- ............................................................................
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Find buffer' })
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

-- Yank/paste to system clipboard
-- ............................................................................
vim.keymap.set({ 'n', 'v' }, "<leader>y", "\"+y")
vim.keymap.set('n', "<leader>Y", "\"+Y")
vim.keymap.set({ 'n', 'v' }, "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- Text formatting mappings
-- ............................................................................
vim.keymap.set('n', 'Q', 'gqap', { desc = 'Reflow paragraph (i.e. remove end of lines)' })
vim.keymap.set('v', 'Q', 'gq', { desc = 'Reflow selected text' })

-- Filesystem mappings
-- ............................................................................
vim.keymap.set('n', '<leader>ep', ":echo expand('%:p')<CR>", { desc = 'Show/echo current path' })
vim.keymap.set('n', '<leader>.', ':Neotree reveal<cr>', { desc = 'Show current file explorer' })

-- View helper windows
-- ............................................................................
vim.keymap.set('n', '<leader>vs', ':SymbolsOutline<cr>', { desc = 'View/toggle symbols', silent = true })
vim.keymap.set('n', '<leader>vf', ':Neotree toggle reveal<cr>',
    { desc = 'View/toggle nvim-tree filesystem explorer', silent = true })
vim.keymap.set('n', '<leader>vq', utils.toggle_quickfix, { desc = 'View/toggle quickfix window', silent = true })
-- Diagnostics (errors, warnings)
vim.keymap.set('n', '<leader>vd', ':Trouble diagnostics toggle filter.buf=0<CR>',
    { desc = 'View/toggle Trouble diagnostics for buffer', silent = true })
vim.keymap.set('n', '<leader>vD', ':Trouble diagnostics toggle<CR>',
    { desc = 'View/toggle Trouble diagnostics for workspace', silent = true })
-- Terminal
vim.keymap.set('n', '<F12>', ':FloatermToggle<CR>', { desc = 'View/toggle Floaterm', silent = true })
vim.keymap.set('t', '<F12>', '<C-\\><C-n>:FloatermToggle<CR>', { desc = 'View/toggle Floaterm', silent = true })

-- Vim tool search
-- ............................................................................
vim.keymap.set('n', '<leader>vh', telescope_builtin.help_tags, { desc = 'View help tags' })
vim.keymap.set('n', '<leader>vk', telescope_builtin.keymaps, { desc = 'View keymappings/keybindings' })
vim.keymap.set('n', '<leader>vc', telescope_builtin.commands, { desc = 'View commands' })
vim.keymap.set('n', '<leader>vm', telescope_builtin.marks, { desc = 'View marks' })
vim.keymap.set('n', '<leader>vj', telescope_builtin.jumplist, { desc = 'View jump list' })
vim.keymap.set('n', '<leader>vr', telescope_builtin.registers, { desc = 'View registers' })

-- Vim configuration helpers
-- ............................................................................
vim.keymap.set('n', '<leader>ev', function() telescope_builtin.find_files({ search_dirs = { "~/.config/nvim/" } }) end,
    { desc = 'Find vim configuration file' })
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { desc = 'Reload (source) the vim settings' })
vim.keymap.set('n', '<leader>eb', ':e ~/.config/nvim/init/bundles.vim<CR>', { desc = 'Quickly edit vim bundles file' })

-- ============================================================================
-- Changes to default behavior (no descriptions, since these aren't commands)
-- ============================================================================

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

-- Miscellaneous
-- ............................................................................
-- Disable default behavior of space (advance one to the right) since space is used as a
-- leader key for some commands.
--
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Duplicate system paste to paste-without-formatting keymap used by other apps.
-- This works in Vimr, but in iterm, this is overridden by a terminal command.
vim.keymap.set({ 'i', 'n', 'v' }, '<S-D-v>', function() vim.cmd(':normal! "+p<CR>') end, { silent = true })
