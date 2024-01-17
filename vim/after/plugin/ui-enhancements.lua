vim.cmd.colorscheme "catppuccin"

require("catppuccin").setup {
  flavour = "mocha",
  color_overrides = {
    mocha = {
      base = "#1a1a1a",
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
