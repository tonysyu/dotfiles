local telescope = require('telescope')
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
    ensure_installed = {
        'graphql',
        'html',
        'java',
        'javascript',
        'json',
        'kotlin',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'rst',
        'scss',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    defaults = {
        path_display = {
            shorten = {
                -- Keep the first and last-three path parts unshortened
                exclude = { 1, -3, -2, -1 },
            },
        },
        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').cycle_history_next,
                ["<C-k>"] = require('telescope.actions').cycle_history_prev,
            },
        },
    },
    pickers = {
        buffers = {
            sort_mru = true,
        },
    },
    extensions = {
        live_grep_args = {
            mappings = {
                i = {
                    -- Add quotes around search term to enable addition of args
                    ["<C-'>"] = lga_actions.quote_prompt(),
                    -- Add quotes around search term and start " --iglob " filter
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                },
            },
        }
    }
}
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'live_grep_args')
