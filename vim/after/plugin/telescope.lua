local telescope = require('telescope')

telescope.setup{
    ensure_installed = {
        'graphql',
        'html',
        'java',
        'javascript',
        'json',
        'kotlin',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'rst',
        'scss',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    defaults = {
        path_display = {
            shorten = {
                -- Keep the first and last-three path parts unshortened
                exclude = {1, -3, -2, -1},
            },
        },
        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').cycle_history_next,
                ["<C-k>"] = require('telescope.actions').cycle_history_prev,
            },
        },
    },
    pickers = {
        buffers = {
            sort_mru = true,
        },
    },
}
pcall(telescope.load_extension, 'fzf')
