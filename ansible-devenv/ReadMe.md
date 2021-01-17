# Automated development environment setup using Ansible

## Pre-requisites

**Install ansible**
```sh
brew install ansible
```

## Usage

To build (or update) the development environment, just run the following in this directory:
```sh
make
```

Underneath the hood, this just runs the following:
```sh
ansible-playbook main.yml -i hosts.yml
```
