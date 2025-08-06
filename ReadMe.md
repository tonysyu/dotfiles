# Dotfiles Configuration

Personal dotfiles for macOS development environments.

## Installation

1. **Clone repository:**
   ```bash
   git clone git@github.com:tonysyu/dotfiles.git
   # or for others:
   git clone https://github.com/tonysyu/dotfiles.git
   ```

2. **Set up development environment:**
   ```bash
   brew install ansible
   cd ~/dotfiles/ansible-devenv
   make
   ```

## What's Included

- **Neovim** - Modern Lua configuration with lazy.nvim plugin manager
- **Zsh** - Enhanced shell with zinit plugins and oh-my-posh theming  
- **Git** - Optimized configuration with delta pager
- **Terminal tools** - Ghostty, btop, lazygit configurations
- **Development tools** - Language-specific settings and shortcuts

## Selective Installation

See `ansible-devenv/ReadMe.md` for options to install only specific components (e.g., Neovim only, skip homebrew packages).

## Architecture

### Core Components

**Ansible Configuration** (`ansible-devenv/`):
See Architecture section in `ansible-devenv/ReadMe.md`

**Neovim Configuration** (`config/nvim/`):
See Architecture section in `config/nvim/ReadMe.md`

**Zsh Configuration** (`config/shell/`):
- Uses zinit for plugin management (`~/.config/zinit`)
- Key plugins: fzf-tab, zsh-autosuggestions, zsh-completions, zsh-syntax-highlighting
- Oh-my-posh for prompt theming (`ohmyposh.toml`)
- Vi-mode enabled

**Git Configuration**:
- Split config: `git/general.gitconfig` (main) and `git/personal.gitconfig`
- Delta pager for enhanced diff viewing
- Useful aliases for common workflows
