# Initialize zinit and load plugins
# ======================================================================================
# zinit.git path should match what's in ./ansible-devenv/roles/zsh/vars/main.yml
ZINIT_HOME="${HOME}/.config/zinit"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

plugins=(
  'zsh-users/zsh-autosuggestions'
  'zsh-users/zsh-completions'
  'zsh-users/zsh-syntax-highlighting'
  'jeffreytse/zsh-vi-mode'
)
for repo in ${plugins[@]};
  # ice depth=1 tells next command to limit history depth of git clone to 1 (most recent)
  do zinit ice depth=1; zinit light $repo;
done

# User configuration
# ======================================================================================
source $(dirname -- $0)/vim/init.zsh

# Use starship prompt theme
eval "$(starship init zsh)"

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

# fzf configuration
# ======================================================================================
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
  echo "git submodule update"
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
