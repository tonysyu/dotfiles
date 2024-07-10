if hash nvim 2>/dev/null; then
    alias vim='nvim'
    alias vimdiff='nvim -d'
    export EDITOR=nvim
    # Use neovim as for `man` command
    export MANPAGER="nvim +Man!"
fi
