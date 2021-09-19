local utils = require('utils')

local noremap = utils.key_map_factory('', { noremap = true, silent = true })
local inoremap = utils.key_map_factory('i', { noremap = true, silent = true })

-- Section headings for reStructuredText
-- Parts
noremap { '<leader>0', 'yyPVr#yyjp' }
inoremap { '<leader>0', '<esc>yyPVr#yyjpA' }
-- Chapters
noremap { '<leader>1', 'yyPVr=yyjp' }
inoremap { '<leader>1', '<esc>yyPVr=yyjpA' }
-- Section Level 1
noremap { '<leader>2', 'yypVr=' }
inoremap { '<leader>2', '<esc>yypVr=A' }
-- Section Level 2
noremap { '<leader>3', 'yypVr-' }
inoremap { '<leader>3', '<esc>yypVr-A' }
-- Section Level 3
noremap { '<leader>4', 'yypVr.' }
inoremap { '<leader>4', '<esc>yypVr.A' }
