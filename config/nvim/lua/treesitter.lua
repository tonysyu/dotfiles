-- Auto-install treesitter parsers (nvim-treesitter main branch for Neovim 0.12+)
-- See https://www.qu8n.com/posts/treesitter-migration-guide-for-nvim-0-12
-- for details on nvim-treesitter configuration for neovim 0.12
local ensure_installed = {
    "bash",
    "c",
    "css",
    "dockerfile",
    "elixir",
    "elm",
    "go",
    "heex",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "markdown_inline",
    "proto",
    "python",
    "rst",
    "rust",
    "scss",
    "sql",
    "templ",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

local installed = require('nvim-treesitter.config').get_installed()
local to_install = vim.iter(ensure_installed)
    :filter(function(parser)
        return not vim.tbl_contains(installed, parser)
    end)
    :totable()

if #to_install > 0 then
    require('nvim-treesitter').install(to_install)
end

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- Treesitter textobjects
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

require("nvim-treesitter-textobjects").setup {
    select = {
        lookahead = true,
    },
    move = {
        set_jumps = true,
    },
}

-- Select keymaps
vim.keymap.set({ "x", "o" }, "aa", function()
    select.select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
    select.select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "af", function()
    select.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    select.select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
    select.select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
    select.select_textobject("@class.inner", "textobjects")
end)

-- Move keymaps
vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
    move.goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]M", function()
    move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
    move.goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
    move.goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
    move.goto_previous_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[M", function()
    move.goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
    move.goto_previous_end("@class.outer", "textobjects")
end)

-- Swap keymaps
vim.keymap.set("n", "<leader>a", function()
    swap.swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>A", function()
    swap.swap_previous("@parameter.inner")
end)

-- Treesitter-context
vim.cmd [[hi TreesitterContextBottom gui=underline guisp=#5f0000 ]]
vim.cmd [[hi TreesitterContext guibg='black']]

require('treesitter-context').setup {
    mode = 'topline',
}
