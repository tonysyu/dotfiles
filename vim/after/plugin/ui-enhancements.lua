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
    -- command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
  -- Display cmdline and menu together
  -- see https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#display-the-cmdline-and-popupmenu-together
  views = {
    cmdline_popup = {
      position = {
        row = 15,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 18, -- This should match the `cmdline_popup.position.row` + ~3
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
})

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'jellybeans',
    component_separators = '|',
    section_separators = '',
  },
  extensions = {
    'fugitive',
    'neo-tree',
    'quickfix',
    'symbols-outline',
    'trouble',
  },
}

-- set up indent-blankline
require("ibl").setup()
