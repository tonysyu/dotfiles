local telescope = require('telescope')

telescope.setup{
	defaults = {
		path_display={"smart"},
	},
    pickers = {
        buffers = {
          sort_mru = true,
        },
    },
}
telescope.load_extension('fzf')
