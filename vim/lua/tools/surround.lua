local function surround_trigger(key)
    return "surround_" .. string.byte(key)
end

vim.g[surround_trigger('w')] = "{{\r}}"
vim.g[surround_trigger('%')] = "{%\r%}"
