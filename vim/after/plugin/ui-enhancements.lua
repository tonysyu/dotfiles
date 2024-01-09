local colorscheme = require('ofirkai').scheme
colorscheme.background = '#1a1a1a'
require('ofirkai').setup {
  scheme = colorscheme,
  custom_hlgroups = {
    LineNr = {
      bg = colorscheme.background,
      fg = '#444444',
    },
    ['@punctuation.delimiter'] = {
      fg = colorscheme.red,
    },
    ['@text.literal'] = {
      fg = '#aaaaaa',
    }
  }
}

require('nvim-web-devicons').setup()

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'jellybeans',
    component_separators = '|',
    section_separators = '',
  },
}

-- Set up indent-blankline
require("ibl").setup()
