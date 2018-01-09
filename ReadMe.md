Configuration files *nix
========================

I use Mac Os, so your mileage might vary on Linux systems.

Installation
------------

- Clone repo:
    ```
    git clone git@github.com:tonysyu/dotfiles.git
    ```
    - or, if you're not me:
        ```
        git clone https://github.com/tonysyu/dotfiles.git
        ```
- Link bash profile:
    - Add `source ~/dotfiles/profile` to your `.profile` (or `.bash_profile`).
- Link `inputrc`, `editrc`, `ackrc`:
    ```
    cd ~
    ln -s ~/dotfiles/inputrc .inputrc
    ln -s ~/dotfiles/editrc .editrc
    ln -s ~/dotfiles/ackrc .ackrc
    ```
- Link vim files
    ```
    mkdir ~/.config
    cd ~/.config
    ln -s ~/dotfiles/vim nvim
    ```
- Install python for neovim
    ```
    pyenv install 2.7.13
    pyenv install 3.6.2

    pyenv virtualenv 2.7.13 neovim2
    pyenv virtualenv 3.6.2 neovim3

    pyenv activate neovim2
    pip install neovim
    pip install flake8

    pyenv activate neovim3
    pip install neovim
    pip install flake8
    ```
- Install vim bundles
    ```
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
    sh install.sh
    rm install.sh
    cd ~/dotfiles/vim/bundle/YouCompleteMe
    ./install.py
    ```
