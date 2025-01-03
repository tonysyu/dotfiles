all:
	ansible-galaxy collection install -r requirements.yml
	ansible-playbook main.yml -i hosts.yml

neovim:
	ansible-playbook main.yml -i hosts.yml -t neovim

no-brew:
	ansible-playbook main.yml -i hosts.yml --skip-tags brew

no-casks:
	ansible-playbook main.yml -i hosts.yml --skip-tags cask
