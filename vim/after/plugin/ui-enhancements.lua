require('monokai').setup {
  palette = {
    name = 'monokai_pro',
    base2 = '#1a1a1a', -- Use darker background color for more contrast
  },
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

require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}
