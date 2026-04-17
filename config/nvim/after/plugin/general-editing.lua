-- Enable Comment.nvim
local default_augroup = vim.api.nvim_create_augroup('GeneralEditingAuGroup', { clear = true })

-- Auto-save when leaving
-- ..........................................................................
vim.api.nvim_create_autocmd('BufLeave', {
    callback = function()
        if vim.bo.modified and vim.bo.buftype == '' and vim.api.nvim_buf_get_name(0) ~= '' then
            vim.cmd('silent! update')
        end
    end,
    group = default_augroup,
    pattern = '*',
})

-- Highlight on yank
-- ..........................................................................
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = default_augroup,
    pattern = '*',
})

-- Quickfix keymaps
-- ..........................................................................
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    desc = 'Attach keymaps for quickfix list',
    -- Delete from quickfix
    -- ......................................................................
    callback = function()
        vim.keymap.set('n', 'dd', function()
            local qf_list = vim.fn.getqflist()

            local current_line_number = vim.fn.line('.')

            if qf_list[current_line_number] then
                table.remove(qf_list, current_line_number)

                vim.fn.setqflist(qf_list, 'r')

                local new_line_number = math.min(current_line_number, #qf_list)
                vim.fn.cursor(new_line_number, 1)
            end
        end, {
            buffer = true,
            noremap = true,
            silent = true,
            desc = 'Remove quickfix item under cursor',
        })
    end
})
