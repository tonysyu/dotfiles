# Aesthetics
# --------------------------------------------------------------------------------------
$env.PROMPT_COMMAND = { || oh-my-posh print primary --config $'~/dotfiles/config/terminal/ohmyposh.toml' }

# History
# --------------------------------------------------------------------------------------
$env.config.history.max_size = 1000

# Editing
# --------------------------------------------------------------------------------------
alias vim = nvim
$env.config.edit_mode = 'vi'
$env.config.buffer_editor = "nvim"
