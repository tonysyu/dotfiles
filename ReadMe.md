Configuration files \*nix
=========================

I use Mac Os, so your mileage might vary on Linux systems.

Prerequisites
-------------

Much of these repository is specifically geared toward configuring vim, or more specifically,
neovim. First you'll need to [install
neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#macos--os-x):

    $ brew install nvim

### Optional

The vim configuration here uses following libraries:
- [fd](https://github.com/sharkdp/fd) to replace the `find` command
- [ripgrep](https://github.com/BurntSushi/ripgrep) for grep-like search
- [fzf](https://github.com/junegunn/fzf#usage) for fuzzy-file-finding (like [command-t](https://github.com/wincent/command-t), [ctrlp](https://github.com/kien/ctrlp.vim))

    $ brew install fd
    $ brew install fzf
    $ brew install ripgrep

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
    - Add `source ~/dotfiles/zshrc` to your `.zshrc`
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
    pip2 install pynvim
    pip3 install pynvim
    ```
- Install vim bundles
    ```
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
    sh install.sh
    rm install.sh
    ```
- [Install `coc.nvim`](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim)
- Install language servers for `coc.nvim` (within vim):
    - `:CocInstall coc-python`
