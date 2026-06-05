require('plugins')

require('settings')
require('tools')
require('key_mappings')
require('lsp')
require('treesitter')
require('custom_commands')

-- Add Cfilter command to filter for or out (!) lines of quickfix window
-- Use w/ delete line (dd) keymap defined in after/plugin/general-editing
-- :Cfilter[!] /{pat}/
vim.cmd('packadd cfilter')
