# Automated development environment setup using Ansible

## Pre-requisites

**Install ansible**
```sh
pipx install ansible --include-deps
```
Without `--include-deps`, the `ansible` command-line tool will not be installed. (See [github issue](https://github.com/pipxproject/pipx/issues/547))

## Usage

Run playbook:
```sh
ansible-playbook main.yml -i hosts.yml
```
