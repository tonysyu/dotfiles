local telescope_builtin = require('telescope.builtin')
local telescope_previewers = require('telescope.previewers')
local live_grep_args = require('telescope').extensions.live_grep_args
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local gitsigns = require('gitsigns')
local snacks = require('snacks')
local utils = require('utils')

-- Prefer `<leader>f` as keymap for find/search that requires input
-- Prefer `<leader>s` as keymap for find/search that uses the current word
-- Prefer `<leader>v` as keymap for viewing panes and find/search is vim-specific

-- Code file search
-- ............................................................................
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, { desc = 'Find/list git files' })
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find/list all files' })
vim.keymap.set('n', '<leader>fr',
    function() telescope_builtin.oldfiles({ only_cwd = true }) end,
    { desc = 'Find/list recent files in current directory' })
vim.keymap.set('n', '<leader>fR', telescope_builtin.oldfiles,
    { desc = 'Find/list recent files across all projects' })

-- Code text search
-- ............................................................................
vim.keymap.set('n', '<leader>fs', function() snacks.picker.lsp_symbols() end,
    { desc = 'Find/search symbol definitions in current file' })
vim.keymap.set('n', '<leader>fg', live_grep_args.live_grep_args, { desc = 'Find/search text using grep/search' })
vim.keymap.set('n', '<leader>*', live_grep_args_shortcuts.grep_word_under_cursor,
    { desc = 'Find/search string under cursor' })
vim.keymap.set('v', '<leader>*', live_grep_args_shortcuts.grep_visual_selection, { desc = 'Find/search selected string' })
vim.keymap.set('n', '<leader>S', ':%s/', { desc = 'Find/search and replace using regex' })
vim.keymap.set('v', '<leader>S', ':s/', { desc = 'Find/search and replace using regex' })
vim.keymap.set('n', '<leader>/', telescope_builtin.current_buffer_fuzzy_find,
    { desc = 'Fuzzy find/search in current buffer' })
vim.keymap.set('n', '<C-S-/>', ':noh<CR>', { desc = 'Clear hlsearch', silent = true })
-- snacks.nvim words plugin highlights current word and allows navigation
vim.keymap.set('n', ']w', function() snacks.words.jump(vim.v.count1) end,
    { desc = 'Next word matching word under cursor', silent = true })
vim.keymap.set('n', '[w', function() snacks.words.jump(-vim.v.count1) end,
    { desc = 'Previous word matching word under cursor', silent = true })

-- Undo ignorecase for star search
vim.keymap.set('n', '*', utils.find_current_word_without_ignorecase,
    { desc = 'Find/search current word under the cursor' })

-- Git
-- ............................................................................
-- Custom telescope previewer to use git diff. This allows reuse of the default git pager,
-- which in our case uses git-delta to show pretty diffs.
-- Copied from https://www.reddit.com/r/neovim/comments/101e5lb/using_delta_in_telescope_git_status/
local git_diff_previewer = telescope_previewers.new_termopen_previewer({
    get_command = function(entry)
        if entry.status == '??' or 'A ' then
            return { 'git', 'diff', entry.value }
        end

        return { 'git', 'diff', entry.value .. '^!' }
    end
})
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches, { desc = 'Find/list git branches' })
vim.keymap.set('n', '<leader>gL',
    function() telescope_builtin.git_commits({ previewer = git_diff_previewer }) end,
    { desc = 'Show git log/commits for repo' })
vim.keymap.set('n', '<leader>gl',
    function()
        local current_file = vim.fn.expand('%:p')
        telescope_builtin.git_commits({
            git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--", current_file },
            previewer = git_diff_previewer,
        })
    end,
    { desc = 'Show git log/commits for file' })
vim.keymap.set('n', '<leader>gs',
    function() telescope_builtin.git_status({ previewer = git_diff_previewer }) end,
    { desc = 'Show git status / changed files' })
vim.keymap.set('n', '<leader>gg', function() snacks.lazygit() end, { desc = 'Open lazygit' })
vim.keymap.set('n', '<leader>gx', telescope_builtin.git_stash, { desc = 'Find/list git stash items' })

-- gitsigns ("c" for code changes)
-- Adapted from https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#keymaps
vim.keymap.set('n', '<leader>cs', gitsigns.stage_hunk, { desc = 'Code change: Stage hunk' })
vim.keymap.set('n', '<leader>cu', gitsigns.undo_stage_hunk, { desc = 'Code change: Unstage hunk' })
vim.keymap.set('n', '<leader>cd', gitsigns.toggle_deleted, { desc = 'Code change: Toggle display of deleted code' })
vim.keymap.set('n', ']c', function()
    if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
    else
        gitsigns.nav_hunk('next')
    end
end, { desc = 'Code change: Next hunk' })

vim.keymap.set('n', '[c', function()
    if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
    else
        gitsigns.nav_hunk('prev')
    end
end, { desc = 'Code change: Previous hunk' })

-- Buffer navigation
-- ............................................................................
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Find buffer' })
vim.keymap.set('n', '<leader><leader>', '<c-^>', { desc = 'Toggle between two, most-recent buffers' })
-- snacks.nvim bufdelete plugin deletes buffer while preserving window layout
vim.keymap.set('n', '<leader>bd', function() snacks.bufdelete() end, { desc = 'Delete buffer', silent = true })

-- Split buffer navigation
-- ............................................................................
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Switch to buffer/pane below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Switch to buffer/pane above ' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Switch to buffer/pane on left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Switch to buffer/pane on right' })

-- Split buffer resizing
-- ............................................................................
vim.keymap.set('n', '<C-S-k>', '5<C-w>+', { desc = 'Increase height of buffer/pane by 5' })
vim.keymap.set('n', '<C-S-j>', '5<C-w>-', { desc = 'Decrease height of buffer/pane by 5' })
vim.keymap.set('n', '<C-S-l>', '5<C-w>>', { desc = 'Increase width fo buffer/pane by 5' })
vim.keymap.set('n', '<C-S-h>', '5<C-w><', { desc = 'Decrease width fo buffer/pane by 5' })

-- Move text line-by-line (see https://youtu.be/hSHATqh8svM)
-- ............................................................................
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected text up' })
vim.keymap.set('n', '<leader>j', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<leader>k', ':m .-2<CR>==', { desc = 'Move line up' })

-- Yank/paste to system clipboard
-- ............................................................................
vim.keymap.set({ 'n', 'v' }, "<leader>y", "\"+y", { desc = 'Yank to clipboard' })
vim.keymap.set('n', "<leader>Y", "\"+Y", { desc = 'Yank line to clipboard' })
vim.keymap.set({ 'n', 'v' }, "<leader>p", "\"+p", { desc = 'Paste from clipboard' })
vim.keymap.set("n", "<leader>P", "\"+P", { desc = 'Paste from clipboard before cursor' })
vim.keymap.set('n', '<leader>yp', ":call setreg('+', expand('%'))<CR>", { desc = 'Save current path to clipboard' })
vim.keymap.set('n', '<leader>yP', ":call setreg('+', expand('%:p'))<CR>",
    { desc = 'Save current absolute path to clipboard' })

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
vim.keymap.set('n', '<leader>vt', ':TodoTelescope<CR>', { desc = 'View Todo list in telescope', silent = true })
-- Diagnostics (errors, warnings)
vim.keymap.set('n', '<leader>vD', function() snacks.picker.diagnostics_buffer() end,
    { desc = 'View/toggle diagnostics for buffer', silent = true })
vim.keymap.set('n', '<leader>vd', function() snacks.picker.diagnostics() end,
    { desc = 'View/toggle diagnostics for workspace', silent = true })
-- snacks.nvim terminal plugin (double escape within to normal mode)
vim.keymap.set({ 'n', 't' }, '<c-/>', function() snacks.terminal() end, { desc = 'Toggle Terminal', silent = true })
-- snacks.nvim notifier plugin
vim.keymap.set('n', '<leader>nn', function() snacks.notifier.show_history() end,
    { desc = 'Show notification history', silent = true })
vim.keymap.set('n', '<leader>nd', function() snacks.notifier.hide() end,
    { desc = 'Hide/delete notification popup', silent = true })

-- Vim tool search
-- ............................................................................
vim.keymap.set('n', '<leader>vh', telescope_builtin.help_tags, { desc = 'View help tags' })
vim.keymap.set('n', '<leader>vk', telescope_builtin.keymaps, { desc = 'View keymappings/keybindings' })
vim.keymap.set('n', '<leader>vc', telescope_builtin.commands, { desc = 'View commands' })
vim.keymap.set('n', '<leader>vm', telescope_builtin.marks, { desc = 'View marks' })
vim.keymap.set('n', '<leader>vj', telescope_builtin.jumplist, { desc = 'View jump list' })
vim.keymap.set('n', '<leader>vr', telescope_builtin.registers, { desc = 'View registers' })
vim.keymap.set('n', '<leader>vv', function() snacks.dashboard.open() end, { desc = 'View home/dashboard' })

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
