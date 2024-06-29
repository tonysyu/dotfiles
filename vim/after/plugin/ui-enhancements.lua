vim.cmd.colorscheme "catppuccin"

require("catppuccin").setup {
  flavour = "mocha",
  color_overrides = {
    mocha = {
      base = "#1a1a1a",
    }
  },
  integrations = {
    treesitter_context = true,
  },
}

require('nvim-web-devicons').setup()

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})

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
