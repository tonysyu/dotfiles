local M = {}

vim.api.nvim_buf_create_user_command(
    0,
    "SanitizeObsidianMarkdown",
    function()
        -- Leave off `g` flag from all regexes since `opt.gdefault = true`
        -- Remove Obsidian internal links (i.e. square brackets) but keep labels.
        vim.api.nvim_command('%s/\\[\\[\\([^\\]]*\\)\\]\\]/\\1/')
        print("Sanitization complete")
    end,
    {}
)

return M
