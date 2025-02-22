require('mini.ai').setup()

require('mini.comment').setup()

require('mini.files').setup()

require('mini.jump').setup()

require('mini.move').setup()

require('mini.operators').setup {
    -- Evaluate text and replace with output
    evaluate = {
        prefix = 'x=',
    },
    -- Exchange text regions (first ;x<motion> selects, second ;x<motion> exchanges)
    exchange = {
        prefix = 'xx',
        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
    },
    -- Multiply (duplicate) text
    multiply = {
        prefix = 'xm',
    },
    -- Replace text with register
    replace = {
        prefix = 'xr',
        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
    },
    -- Sort text
    sort = {
        prefix = 'xs',
    }
}

require('mini.pairs').setup()

require('mini.splitjoin').setup()

require('mini.surround').setup()
