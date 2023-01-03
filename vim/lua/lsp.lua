local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local telescope_builtin = require('telescope.builtin')
local utils = require('utils')

-- Simple plugin setup
require('fidget').setup()
require("symbols-outline").setup()
require("neodev").setup() -- IMPORTANT: must setup neodev BEFORE lspconfig

local custom_server_options = {}
custom_server_options['sumneko_lua'] = {
    settings = {
        Lua = {
            -- Avoid 'global vim is undefined' errors when editing neovim config files.
            -- See https://www.reddit.com/r/neovim/comments/khk335/lua_configuration_global_vim_is_undefined/
            diagnostics = {
                globals = { 'vim' }
            },
            -- Avoid luassert configuration popup
            -- See https://github.com/sumneko/lua-language-server/discussions/1688
            workspace = {
                checkThirdParty = false,
            },
        }
    }
}

-- Attach keymappings to LSP servers
-- See https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local function on_attach(client, bufnr)
    -- Definitions and references
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, { desc = 'Go to definition' })
    vim.keymap.set('n', '<leader>si', telescope_builtin.lsp_implementations, { desc = 'Find/search implementation' })
    vim.keymap.set('n', '<leader>sr', telescope_builtin.lsp_references, { desc = 'Find/search references' })
    vim.keymap.set('n', '<leader>st', telescope_builtin.lsp_type_definitions, { desc = 'Find/search type definition' })

    -- Code search
    vim.keymap.set('n', '<leader>fs', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'Find/search symbol through search input' })
    vim.keymap.set('n', '<leader>ss', function ()
        telescope_builtin.lsp_workspace_symbols {
            query=vim.call('expand','<cword>')
        }
    end, { desc = 'Find symbol under cursor' })

    -- Documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation' })
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous LSP diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next LSP diagnostic' })

    -- Editing
    vim.keymap.set('n', '<leader>va', vim.lsp.buf.code_action, { desc = 'View LSP code action' })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = 'Rename' })
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, { desc = 'Reformat' })
end

mason.setup()

mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = cmp_nvim_lsp.default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            ),
        }

        utils.update_table(opts, custom_server_options[server_name])

        lspconfig[server_name].setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
    end
})

local luasnip = require 'luasnip'

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
    sources = {
        { name = 'nvim_lsp' },
        { name = "luasnip" },
    }
})
