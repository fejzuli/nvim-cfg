return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    version = false,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    opts = {
        ensure_installed = {
            -- these five parsers should always be installed
            "c", "lua", "vim", "vimdoc", "query",
            -- others
            "bash", "fish",
            "cpp", "rust",
            "cmake", "make",
            "gdscript",
            "regex",
            "html", "css", "javascript",
            "markdown", "json", "toml", "yaml",
            "gitignore",
        },
        sync_install = false,
        auto_install = true,
        -- modules
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
