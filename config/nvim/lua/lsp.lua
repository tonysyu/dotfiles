local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local luasnip = require('luasnip')
-- Load snipmate style snippets from snippets.
require("luasnip.loaders.from_snipmate").lazy_load()

-- Simple plugin setup
require('fidget').setup()

-- Configure Mason
mason.setup()

-- Set up LSP capabilities for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Apply capabilities to all servers globally
vim.lsp.config('*', { capabilities = capabilities })

-- Server-specific configurations
vim.lsp.config['lua_ls'] = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
        }
    }
}

vim.lsp.config['kotlin_language_server'] = {
    -- Ensure proper root directory detection for Kotlin projects
    root_markers = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", "pom.xml" },
    handlers = {
        -- Disable document highlight to fix: kotlin_language_server: -32602: Internal error.
        ["textDocument/documentHighlight"] = function() end,
    },
    init_options = {
        -- Automatically refresh when build files change
        storagePath = vim.fn.stdpath("data") .. "/kotlin-language-server",
    },
    settings = {
        kotlin = {
            -- Enable code completion from external sources
            completion = {
                snippets = {
                    enabled = true
                }
            },
            -- Increase indexing for generated sources
            indexing = {
                enabled = true
            },
            -- Configure compiler settings to match your build
            compiler = {
                jvm = {
                    target = "17" -- Adjust to your JVM target version
                }
            }
        }
    }
}

-- Enable all Mason-installed servers (automatic_enable = true by default in v2)
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
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "luasnip" },
        { name = 'buffer' },
        { name = 'path' },
    })
})
