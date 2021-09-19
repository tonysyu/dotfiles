local bo = vim.bo  -- buffer-local option

-- snipMate requires tabs when defining snippets
bo.expandtab = false
-- show whitespace characters
bo.list = true

bo.commentstring = '#%s'
