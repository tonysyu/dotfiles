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

## Troubleshooting

### Python Version Upgrades

When python versions change, the `py3nvim` virtual environment needs to be recreated.
Delete the original directory, then recreate it:
```bash
rm -rf ~/dotfiles/config/nvim/.venv/py3nvim
ansible-playbook main.yml -i hosts.yml -t python
```
(Alternatively, replace the last line with `make`, but that will be slower)

The following error (when building the dev env) is a symptom of this issue:
```bash
[Errno 2] No such file or directory: b'/Users/tonyyu/dotfiles/config/nvim/.venv/py3nvim/bin/pip3'"
```
