# Automated Development Environment Setup

Uses Ansible to configure macOS development environment with dotfiles and tools.

## Prerequisites

```bash
brew install ansible
```

## Usage

### Full Environment Setup
```bash
make
```
Equivalent to: `ansible-playbook main.yml -i hosts.yml`

### Selective Installation
```bash
make neovim        # Install only Neovim configuration
make no-brew       # Skip homebrew package installation
make no-casks      # Skip homebrew cask installation
```

## What Gets Installed

- **Common tools**: Basic CLI utilities and configurations
- **Zsh**: Shell configuration with zinit and plugins
- **Neovim**: Complete development environment setup
- **Development packages**: Language tools and utilities via homebrew

## Architecture
- Role-based structure: `common`, `zsh`, `dev-common`, `dev-neovim`
- Main playbook: `main.yml` with inventory in `hosts.yml`
- Makefile provides convenient installation targets
