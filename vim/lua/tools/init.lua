require('tools.buftabline')
require('tools.closetag')
require('tools.emmet')
require('tools.indent-blankline')
require('tools.lightline')
require('tools.surround')
require('tools.telescope')
require('tools.ultisnips')

-- Basic setup scripts
-- Only include _very_ basic tool setup. Customizations should go in separate files
require('nvim-web-devicons').setup()
require("symbols-outline").setup()
require("trouble").setup {}
