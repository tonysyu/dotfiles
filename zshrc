# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump
    git
    nvm
    vi-mode
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $(dirname -- $0)/vim/aliases.zsh

# User configuration

# Add homebrew python versions to path
# Should match versions in ~/dotfiles/ansible-devenv/roles/dev-common/vars/main.yml
export PATH=/usr/local/opt/python@3.8/bin:$PATH
export PATH=/usr/local/opt/python@3.9/bin:$PATH
export PATH=/usr/local/opt/python@3.10/bin:$PATH

# Use neovim as for `man` command
export MANPAGER="nvim +Man!"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls='exa'
alias ll='exa -l'
alias lt='exa --tree --level=2'

# Gradle wrapper. Note that this overrides oh-my-zsh git plugin alias for `git remote`
alias gr='./gradlew'
alias gw='./gradlew'

# Initialize zoxide
eval "$(zoxide init zsh)"

# vi-mode: Cursor changes between insert and normal mode
VI_MODE_SET_CURSOR=true

# Directory-colors
# Copied from https://unix.stackexchange.com/a/91978
if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

# Initialize key bindings for fzf
# See https://junegunn.github.io/fzf/installation/
eval "$(fzf --zsh)"

# Initialize fzf-git
# Use <Ctrl-G><Ctrl-X> where X is
#     F = Files
#     B = Branches
#     H = commit Hashes
#     R = Remotes
#     S = Stashes
# See https://github.com/junegunn/fzf-git.sh?tab=readme-ov-file#list-of-bindings
fzf_git_bin="$HOME/dotfiles/fzf-git.sh/fzf-git.sh"
if test -f "$fzf_git_bin"; then
  source "$fzf_git_bin"
else
  echo "Could not find $fzf_git_bin. Execute the following:"
  echo "cd ~/dotfiles"
  echo "git submodule sync"
fi

# frg: Command to search files by ripgrep, refine with fzf, and open in vim:
# See https://junegunn.github.io/fzf/tips/ripgrep-integration/
function frg {
    result=`rg --ignore-case --color=always --line-number --no-heading "$@" |
      fzf --ansi \
          --color 'hl:-1:underline,hl+:-1:underline:reverse' \
          --delimiter ':' \
          --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'`
    file="${result%%:*}"
    linenumber=`echo "${result}" | cut -d: -f2`
    if [ ! -z "$file" ]; then
            $EDITOR +"${linenumber}" "$file"
    fi
}
