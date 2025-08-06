# Neovim Configuration

Modern Neovim setup using lazy.nvim plugin manager with Lua configuration.

## Architecture

### Plugin Management

This configuration uses **lazy.nvim**. Plugins are automatically installed on first run.

### Key Features

- **LSP Integration**: Full language server support with Mason
- **Telescope**: Fuzzy finding for files, symbols, and text
- **Treesitter**: Enhanced syntax highlighting and text objects
- **Git Integration**: Gitsigns and telescope git extensions
- **Modular Structure**: Organized Lua modules for maintainability

### Keymap Philosophy

- `<leader>f` - Find/search requiring input (files, text)
- `<leader>s` - Search using current word
- `<leader>v` - Vim-specific views and panes
- Leader key: `,` (comma)

### Configuration Structure

- `init.lua` - Entry point
- `lua/plugins.lua` - Plugin definitions
- `lua/settings.lua` - Neovim options
- `lua/key_mappings.lua` - Custom keymaps
- `lua/lsp.lua`: LSP configuration
- `after/plugin/` - Plugin-specific configs
