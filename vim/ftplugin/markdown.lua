local utils = require('utils')

local noremap = utils.key_map_factory('', { noremap = true, silent = true })
local inoremap = utils.key_map_factory('i', { noremap = true, silent = true })

-- Section Level 1
noremap { '<leader>1', 'yypVr=' }
inoremap { '<leader>1', '<esc>yypVr=A' }
-- Section Level 2
noremap { '<leader>2', 'yypVr-' }
inoremap { '<leader>2', '<esc>yypVr-A' }
-- Section Level 3
noremap { '<leader>3', 'I### ' }
inoremap { '<leader>3', '<esc>I### ' }
-- Section Level 4
noremap { '<leader>4', 'I#### ' }
inoremap { '<leader>4', '<esc>I#### ' }
