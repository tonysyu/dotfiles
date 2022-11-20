local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Attach keymappings to LSP servers
-- See https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local function on_attach(client, bufnr)
    -- Definitions and references
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Go to declaration' })
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Go to definition' })
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Go to implementation' })
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = 'Go to references' })
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'Go to type definition' })

    -- Documentation
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Show documentation' })
    vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Show signature help' })

    -- Diagnostics
    vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { desc = 'Go to previous LSP diagnostic' })
    vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { desc = 'Go to next LSP diagnostic' })

    -- Editing
    vim.keymap.set('n', '<space>sa', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Show LSP code action' })
    vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
    vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { desc = 'Reformat' })
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
