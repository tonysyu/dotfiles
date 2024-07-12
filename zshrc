# Initialize zinit and load plugins
# ======================================================================================
# zinit.git path should match what's in ./ansible-devenv/roles/zsh/vars/main.yml
ZINIT_HOME="${HOME}/.config/zinit"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

plugins=(
  'zsh-users/zsh-autosuggestions'
  'zsh-users/zsh-completions'
  'zsh-users/zsh-syntax-highlighting'
)
for repo in ${plugins[@]};
  # ice depth=1 tells next command to limit history depth of git clone to 1 (most recent)
  do zinit ice depth=1; zinit light $repo;
done

# Use oh-my-zsh vi-mode plugin
# The jeffreytse/zsh-vi-mode plugin clashes with fzf keybindings AND history-search-*
# See https://github.com/jeffreytse/zsh-vi-mode/issues/24
zinit snippet OMZP::vi-mode
VI_MODE_SET_CURSOR=true

# User configuration
# ======================================================================================
source $(dirname -- $0)/vim/init.zsh

# Initialize prompt theme
# Wrap conditional, since default Apple terminal is not supported
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.toml)"
fi

# Initialize zoxide
eval "$(zoxide init zsh)"

# Add homebrew python versions to path
# Should match versions in ~/dotfiles/ansible-devenv/roles/dev-common/vars/main.yml
export PATH=/usr/local/opt/python@3.8/bin:$PATH
export PATH=/usr/local/opt/python@3.9/bin:$PATH
export PATH=/usr/local/opt/python@3.10/bin:$PATH

alias ls='exa'
alias ll='exa -l'
alias lt='exa --tree --level=2'

alias gr='./gradlew'
alias gw='./gradlew'

# History search configuration
# ======================================================================================
# Adapted from https://github.com/dreamsofautonomy/zensh/blob/main/.zshrc
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=5000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
# Ignore commands with leading space (useful for ignoring secrets)
setopt hist_ignore_space
# Ignore duplicate commands
HISTDUP=erase
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# fzf configuration
# ======================================================================================
# Initialize key bindings for fzf
# See https://junegunn.github.io/fzf/installation/
eval "$(fzf --zsh)"

# Initialize fzf-git
# See https://github.com/junegunn/fzf-git.sh?tab=readme-ov-file#list-of-bindings
source "$HOME/dotfiles/fzf-git.sh/fzf-git.sh"

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
