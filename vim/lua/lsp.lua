local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local telescope_builtin = require('telescope.builtin')
local utils = require('utils')
local luasnip = require('luasnip')
-- Load snipmate style snippets from snippets.
require("luasnip.loaders.from_snipmate").lazy_load()

-- Simple plugin setup
require('fidget').setup()
require("symbols-outline").setup()
require("neodev").setup() -- IMPORTANT: must setup neodev BEFORE lspconfig

vim.lsp.config['lua_ls'] = {
    settings = {
        Lua = {
            -- Avoid 'global vim is undefined' errors when editing neovim config files.
            -- See https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
            diagnostics = {
                globals = { 'vim' }
            },
        }
    }
}

mason.setup()
mason_lspconfig.setup()

-- Configure completion
-- Ensure completion options are displayed
vim.opt.completeopt = "menu,menuone,noselect"
-- Setup nvim-cmp (https://github.com/hrsh7th/nvim-cmp/)
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "luasnip" },
        { name = 'buffer' },
        { name = 'path' },
    })
})
