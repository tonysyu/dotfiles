local telescope = require('telescope')

telescope.setup{
    pickers = {
        buffers = {
          sort_mru = true,
        },
    },
}
telescope.load_extension('fzf')
