# --------------------
# General shell tweaks
# --------------------

# Customize path
export PATH=$HOME/bin:$HOME/code/bin:$PATH

# Colorize terminal
export CLICOLOR=1

# Replace ls with exa (https://github.com/ogham/exa)
alias ls='exa'

function lst () {
    exa --tree --level="${@:-2}"
}

# -----------
# Text editor
# -----------

if hash nvim 2>/dev/null; then
    alias vim='nvim'
    alias vimdiff='nvim -d'
fi

export EDITOR=vim

# ----------------------
# Python-specific tweaks
# ----------------------

# Shortcuts for common operations
alias build-inplace='python setup.py build_ext --inplace'
alias build-clean='find . -name *.so -or -name *.pyc | xargs rm; rm -rf build'
alias pstats='python -m pstats'
alias remove-pycache='find . | grep -E "(__pycache__|\.pyc$)" | xargs rm -rf'

# Change to Python's site-packages directory.
function cdsite {
  cd "$(python -c "import site; \
    print(site.getsitepackages()[0])"
  )"
}

# Change to the directory for a given python module
function cdpy {
  cd "$(python -c "import imp; print(imp.find_module('$1')[1])"
)"
}

# Profile and output to `less` pager
# (Note: this gives an error if you don't go to the end of the buffer)
function quickprof {
    python -m cProfile -s cumulative "$@" | less
}

# -------------------
# Git-specific tweaks
# -------------------

# Count the total number of commits for a branch.
alias git-count="git log --pretty=format:'x' | wc -l"

# Parse git branch state and display at prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1 | awk '{print $1}') != "nothing" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
function show_venv {
  [[ $VIRTUAL_ENV ]] && echo "(${VIRTUAL_ENV##*/})"
}

RED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIME='\[\033[1;32m\]'
YELLOW='\[\033[0;33m\]'
CYAN='\[\033[1;34m\]'
NO_COLOR='\[\033[0m\]'
export PS1='\n'$LIME'\u'$NO_COLOR'@\h'$RED'$(show_venv)'$NO_COLOR':'$CYAN'\w'$YELLOW'$(parse_git_branch)\n'$RED'$ '$NO_COLOR
export _OLD_VIRTUAL_PS1=$PS1
export CONDA_OLD_PS1=$PS1

# ---------------------------
# Application-specific tweaks
# ---------------------------

# Save fzf history. Press Ctrl-P to cycle through old searches.
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# autojump-generated snippet
[[ -s ~/.autojump/etc/profile.d/autojump.bash ]] && . ~/.autojump/etc/profile.d/autojump.bash
