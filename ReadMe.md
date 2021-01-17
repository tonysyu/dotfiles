Configuration files \*nix
=========================

I use Mac Os, so your mileage might vary on Linux systems.


Installation
------------

- Clone repo:
    ```sh
    git clone git@github.com:tonysyu/dotfiles.git
    ```
    - or, if you're not me:
        ```sh
        git clone https://github.com/tonysyu/dotfiles.git
        ```
- Link bash profile:
    - Add `source ~/dotfiles/zshrc` to your `.zshrc`
- Link vim files
    ```sh
    mkdir ~/.config
    cd ~/.config
    ln -s ~/dotfiles/vim nvim
    ```
- Use ansible to set up dev environment
    ```sh
    brew install ansible
    cd ~/dotfiles/ansible-devenv
    make
    ```
- Install language servers for `coc.nvim` (within vim):
    - `:CocInstall coc-python`
