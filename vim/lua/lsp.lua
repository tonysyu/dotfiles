local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')

-- Attach keymappings to LSP servers
-- See https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local function on_attach(client, bufnr)
    local function normal_map(...) vim.api.nvim_buf_set_keymap(bufnr, 'n', ...) end
    local function insert_map(...) vim.api.nvim_buf_set_keymap(bufnr, 'i', ...) end

    local opts = { noremap=true, silent=true }

    -- Definitions and references
    normal_map('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    normal_map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    normal_map('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    normal_map('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    normal_map('gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    -- Documentation
    normal_map('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    normal_map('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    insert_map('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    -- Diagnostics
    normal_map('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    normal_map(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    -- Editing
    normal_map('<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    normal_map('<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = cmp_nvim_lsp.update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        ),
    }

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

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
