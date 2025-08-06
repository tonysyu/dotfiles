require("obsidian").setup({
    workspaces = {
        {
            name = "default",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/wiki",
        },
    },
    daily_notes = {
        folder = "Daily Notes",
    },
    attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- Relative paths are interpreted as relative to the vault root.
        img_folder = "media",
    },
})

vim.keymap.set('n', '<space>oo', ':ObsidianQuickSwitch<CR>', { desc = 'Obsidian: Quick switch notes' })
vim.keymap.set('n', '<space>oO', ':ObsidianOpen<CR>', { desc = 'Obsidian: Open current file in Obsidian app' })
vim.keymap.set('n', '<space>ob', ':ObsidianBacklinks<CR>', { desc = 'Obsidian: Open picker for backlinks' })
vim.keymap.set('n', '<space>od', ':ObsidianDailies<CR>', { desc = 'Obsidian: Open daily note picker' })
vim.keymap.set('n', '<space>ot', ':ObsidianToday<CR>', { desc = 'Obsidian: Open today\'s daily note' })
vim.keymap.set('n', '<space>oT', ':ObsidianTomorrow<CR>', { desc = 'Obsidian: Open tomorrow\'s daily note' })
vim.keymap.set('n', '<space>oc', ':ObsidianTOC<CR>',
    { desc = 'Obsidian: Open picker with table of contents of current note' })
