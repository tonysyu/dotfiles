local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local utils = require('utils')

local custom_server_options = {}
-- Avoid 'global vim is undefined' errors when editing neovim config files.
-- See https://www.reddit.com/r/neovim/comments/khk335/lua_configuration_global_vim_is_undefined/
custom_server_options['sumneko_lua'] = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- Attach keymappings to LSP servers
-- See https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local function on_attach(client, bufnr)
    -- Definitions and references
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })

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

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = "ultisnips" },
    }
})
