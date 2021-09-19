local bind = vim.api.nvim_set_keymap

local M = {}

function M.key_map_factory(mapping_type, options)
    return function(args)
        key, command = unpack(args)
        return bind(mapping_type, key, command, options)
    end
end

function M.toggle_quickfix()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd('cclose')
            return
        end
    end
    vim.cmd('copen')
end

return M
