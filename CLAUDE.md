# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository for macOS development environments. See `ReadMe.md` for installation instructions and `ansible-devenv/ReadMe.md` for automated setup details.

## Key Commands

Refer to existing documentation:
- **Overview**: See `ReadMe.md` overview of project
- **Dev environment management**: See `ansible-devenv/ReadMe.md` for environment setup
- **Neovim setup**: See `config/nvim/ReadMe.md` for plugin installation
- **Ansible targets**: See `ansible-devenv/Makefile` for available commands

## Architecture for Claude Code

### Repository Structure
- **Ansible-managed**: Uses roles in `ansible-devenv/` for automated setup
- **Modular Neovim**: Lua-based configuration with lazy.nvim plugin manager
- **Enhanced Zsh**: Uses zinit for plugin management at `~/.config/zinit`

### Key Locations for Code Changes
- Neovim configs: `config/nvim/lua/` modules and `config/nvim/after/plugin/`
- Shell configs: `config/shell/zshrc`, `config/shell/zshenv` 
- Ansible roles: `ansible-devenv/roles/`
- Git configs: `git/general.gitconfig`, `git/personal.gitconfig`

### Important Notes

- The vim configuration expects `<leader>` to be comma (`,`)
- Zinit path should match `ansible-devenv/roles/zsh/vars/main.yml`
- No traditional build/test commands - this is a configuration repository
- Changes to shell configuration require shell restart or `source ~/.zshrc`

### Development Workflow

When making changes:
1. Test changes locally first
2. For Neovim plugins, update `lazy-lock.json` when adding/updating
3. For system-wide changes, update appropriate ansible role in `ansible-devenv/roles/`
4. Use `make` targets in `ansible-devenv/` to apply changes
5. Shell changes require restart or `source ~/.zshrc` (which sources `config/shell/zshrc`)

## Documentation Guidelines

- Keep documentation that's useful for human developers in `ReadMe.md` files and reference them in `CLAUDE.md`, unless doing so would negatively impact performance
