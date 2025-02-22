-- Enable Comment.nvim
local default_augroup = vim.api.nvim_create_augroup('GeneralEditingAuGroup', { clear = true })

-- Auto-save when leaving
-- ..........................................................................
vim.api.nvim_create_autocmd('BufLeave', {
    command = 'wall',
    group = default_augroup,
    pattern = '*',
})

-- Highlight on yank
-- ..........................................................................
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = default_augroup,
    pattern = '*',
})
