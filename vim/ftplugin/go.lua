-- Limit configuration to buffer-local options (bo)
local opt = vim.bo

-- Set textwidth to 100 to match default used by https://github.com/segmentio/golines
opt.textwidth = 100

-- Go best practice is tabs, not spaces
opt.expandtab = false
