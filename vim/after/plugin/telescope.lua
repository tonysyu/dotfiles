local telescope = require('telescope')
local actions = require('telescope.actions')
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
                    -- Freeze the current list and start a fuzzy search in the frozen list
                    ["<C-space>"] = actions.to_fuzzy_refine,
                },
            },
        }
    }
}
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'live_grep_args')

-- Custom backdgrop for Telescope picker
-- Copied from https://github.com/nvim-telescope/telescope.nvim/issues/3020#issuecomment-2439446111
local blend = 50

vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopePrompt",
    callback = function(ctx)
        local backdropName = "TelescopeBackdrop"
        local telescopeBufnr = ctx.buf

        -- `Telescope` does not set a zindex, so it uses the default value
        -- of `nvim_open_win`, which is 50: https://neovim.io/doc/user/api.html#nvim_open_win()
        local telescopeZindex = 50

        local backdropBufnr = vim.api.nvim_create_buf(false, true)
        local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
            relative = "editor",
            row = 0,
            col = 0,
            width = vim.o.columns,
            height = vim.o.lines,
            focusable = false,
            style = "minimal",
            zindex = telescopeZindex - 1, -- ensure it's below the reference window
        })

        vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
        vim.wo[winnr].winhighlight = "Normal:" .. backdropName
        vim.wo[winnr].winblend = blend
        vim.bo[backdropBufnr].buftype = "nofile"

        -- close backdrop when the reference buffer is closed
        vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
            once = true,
            buffer = telescopeBufnr,
            callback = function()
                if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
                if vim.api.nvim_buf_is_valid(backdropBufnr) then
                    vim.api.nvim_buf_delete(backdropBufnr, { force = true })
                end
            end,
        })
    end,
})
