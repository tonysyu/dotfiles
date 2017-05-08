# --------------------
# General shell tweaks
# --------------------

# Customize path
export PATH=$HOME/bin:$HOME/code/bin:$PATH

# Colorize terminal
export CLICOLOR=1

function refresh-ctags () {
    # Ensure that we're creating tags in the root of a git repository.
    if [ -d "./.git" ]; then
        ctags -R -o ./.tags
        echo "Updated .tags directory."
    else
        echo "refresh-ctags must be run in directory containing .git directory."
    fi
}

# Test whether --color is an allowed option for 'ls'
eval 'ls --color > /dev/null 2>&1'
if [ $? -eq 0 ]; then
    alias ls='ls -hF --color=auto'
else
    alias ls='ls -hFG'
fi

alias vim='nvim'

function findext() {
    find . -regextype posix-egrep -regex ".*\.($1)$"
}

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

RED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
NO_COLOR='\[\033[0m\]'
export PS1='\n\u:\w'$YELLOW'$(parse_git_branch)\n'$RED'$ '$NO_COLOR
export _OLD_VIRTUAL_PS1=$PS1
export CONDA_OLD_PS1=$PS1

# ---------------------------
# Application-specific tweaks
# ---------------------------

# autojump-generated snippet
[[ -s ~/.autojump/etc/profile.d/autojump.bash ]] && . ~/.autojump/etc/profile.d/autojump.bash
