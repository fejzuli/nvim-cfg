return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                -- these five parsers should always be installed
                "c", "lua", "vim", "vimdoc", "query",
                -- others
                "bash", "fish",
                "cmake", "make",
                "markdown", "json", "jsonc", "ron", "toml", "yaml",
                "regex", "gitignore",
            },
            -- tree-sitter-cli recommended if set to true
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "benknoble/vim-racket",
        version = false,
        lazy = false,
        priority = 500,
    },
    {
        "numToStr/Comment.nvim",
        version = "0.*",
        dependencies = { "nvim-ts-context-commentstring" },
        event = "VeryLazy",
        keys = {
            { "gcc", desc = "Toggle comment on line" },
            { "gbc", desc = "Toggle block-comment on line" },
            { "gcO", desc = "Add comment on line above" },
            { "gco", desc = "Add comment on line below" },
            { "gcA", desc = "Add comment at end of line" },
            { "gc", mode = "o", desc = "Toggle comment for motion" },
        },
        opts = {},
        config = function(_, opts)
            opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
            require("Comment").setup(opts)
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        version = false,
        dependencies = { "nvim-treesitter" },
        lazy = true,
        init = function() vim.g.skip_ts_context_commentstring_module = true end,
        opts = { enable_autocmd = false },
    },
}
