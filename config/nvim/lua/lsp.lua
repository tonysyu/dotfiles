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

-- Configure Mason
mason.setup()

-- Set up LSP capabilities for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Configure Mason-lspconfig with automatic server setup
mason_lspconfig.setup({
    handlers = {
        -- Default handler for all servers
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,

        -- Special configuration for specific servers

        ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                    }
                }
            })
        end,

        ["kotlin_language_server"] = function()
            lspconfig.kotlin_language_server.setup({
                capabilities = capabilities,
                -- Ensure proper root directory detection for Kotlin projects
                root_dir = lspconfig.util.root_pattern("settings.gradle", "settings.gradle.kts", "build.gradle",
                    "build.gradle.kts", "pom.xml"),
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
            })
        end,
    }
})

-- require("java").setup({})
--
-- -- List of LSP servers to be installed using mason with the help of mason-lspconfig
-- local servers = {
--     jdtls = {
--         settings = {
--             java = {
--                 configuration = {
--                     runtimes = {
--                         {
--                             name = "Java 17",
--                             -- Match path from $JAVA_HOME
--                             path = "/Library/Java/JavaVirtualMachines/jdk17.0.16.jdk/Contents/Home",
--                             default = true,
--                         }
--                     }
--                 }
--             }
--         }
--     }
-- }
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
--
-- mason_lspconfig.setup({
--   ensure_installed = vim.tbl_keys(servers),
-- })
-- mason_lspconfig.setup_handlers({
--   function(server_name)
--     require("lspconfig")[server_name].setup({
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     })
--   end,
-- })


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
