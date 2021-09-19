local bind = vim.api.nvim_set_keymap

local M = {}

function M.key_map_factory(mapping_type, options)
    return function(args)
        key, command = unpack(args)
        return bind(mapping_type, key, command, options)
    end
end

return M
