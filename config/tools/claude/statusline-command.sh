#!/bin/sh

# Read JSON input from stdin
input=$(cat)

# Extract model name (drop parentheses, e.g. "(1M context)")
model=$(echo "$input" | jq -r '.model.display_name // "Unknown" | gsub(" \\(.*"; "")')

# Extract context usage format as percentage (e.g. ~12%)
percent_used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
percent_used=$(printf "~%.0f%%" "$percent_used")

# Extract context size and format as K (e.g., 200000 -> 200K)
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
context_k=$(printf "%dK" $((context_size / 1000)))

# Extract cost and format as dollars w/ cent precision (e.g. $0.12)
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
cost=$(printf "\$%.2f" "$cost")

# Get current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir=$(basename "$cwd")

# Build git branch info (skip optional locks)
branch=""
if [ -n "$cwd" ] && [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi
# Append branch to directory, if found
if [ -n "$branch" ]; then
  dir="${dir} (${branch})"
fi

# Display: "Opus 4.5 | ~21% of 200K | my-project (main) | $0.12"
echo "[${model}] ${percent_used} of ${context_k} | $dir | $cost"
