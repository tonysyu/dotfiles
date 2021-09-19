local g = vim.g

g.lightline = {
    active = {
        left = {
            { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' }
        }
    },
    component_function = {
        gitbranch = 'fugitive#head'
    },
}
