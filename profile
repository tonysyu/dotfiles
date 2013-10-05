# --------------------
# General shell tweaks
# --------------------

# Use Vi bindings
set -o vi

# Customize path
export PATH=$HOME/bin:$HOME/code/bin:$PATH

# Colorize terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# ----------------------
# Python-specific tweaks
# ----------------------

# Activate Canopy virtual environment
source $HOME/Library/Enthought/Canopy_64bit/User/bin/activate

# Shortcuts for common operations
alias build_inplace='python setup.py build_ext --inplace'
alias build_clean='find . -name *.so -or -name *.pyc | xargs rm; rm -rf build'
alias pstats='python -m pstats'

# Change to Python's site-packages directory.
function cdsite {
  cd "$(python -c "import site; \
    print site.getsitepackages()[0]"
  )"
}

# Change to the directory for a given python module
function cdpy {
  cd "$(python -c "import os.path as p, ${1}; \
    print p.dirname(p.realpath(${1}.__file__[:-1]))"
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

# git tab completion
source '/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash'

# Parse git branch state and display at prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1 | awk '{print $1}') != "nothing" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

RED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
NO_COLOR='\[\033[0m\]'
export PS1='\n\u:\w'$YELLOW'$(parse_git_branch)\n'$RED'$ '$NO_COLOR

# ---------------------------
# Application-specific tweaks
# ---------------------------

# autojump-generated snippet
[[ -s ~/.autojump/etc/profile.d/autojump.bash ]] && . ~/.autojump/etc/profile.d/autojump.bash
