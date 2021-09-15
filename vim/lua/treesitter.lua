local configs = require('nvim-treesitter.configs')
configs.setup {
    ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "elixir",
        "elm",
        "go",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "python",
        "rst",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}
