vim.g.sonokai_colors_override = {
  bg0={'#1a1a1a', '235'},
}
vim.cmd("colorscheme sonokai")

require('nvim-web-devicons').setup()

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'sonokai',
    component_separators = '|',
    section_separators = '',
  },
}

require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}
