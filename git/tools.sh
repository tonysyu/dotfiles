# Output merge-base diff range for a branch vs the default branch.
# Usage: git diff $(mr-diff-range), git diff $(mr-diff-range some-branch)
mr-diff-range() {
  local branch="${1:-HEAD}"
  local default
  default=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  : "${default:=main}"
  echo "$(git merge-base "$default" "$branch")..$branch"
}
