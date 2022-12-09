local telescope = require('telescope')

telescope.setup{
	defaults = {
        path_display = {
            shorten = {
                -- Keep the first and last-three path parts unshortened
                exclude = {1, -3, -2, -1},
            },
        },
	},
    pickers = {
        buffers = {
          sort_mru = true,
        },
    },
}
telescope.load_extension('fzf')
